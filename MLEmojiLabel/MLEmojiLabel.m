//
//  MLEmojiLabel.m
//  MLEmojiLabel
//
//  Created by molon on 5/19/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import "MLEmojiLabel.h"

#pragma mark - 正则列表

#define REGULAREXPRESSION_OPTION(regularExpression,regex,option) \
\
static inline NSRegularExpression * k##regularExpression() { \
    static NSRegularExpression *_##regularExpression = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _##regularExpression = [[NSRegularExpression alloc] initWithPattern:(regex) options:(option) error:nil];\
    });\
    \
    return _##regularExpression;\
}\


#define REGULAREXPRESSION(regularExpression,regex) REGULAREXPRESSION_OPTION(regularExpression,regex,NSRegularExpressionCaseInsensitive)


REGULAREXPRESSION(URLRegularExpression,@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)")

REGULAREXPRESSION(PhoneNumerRegularExpression, @"\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[358]+\\d{9}|\\d{8}|\\d{7}")

REGULAREXPRESSION(EmailRegularExpression, @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}")

REGULAREXPRESSION(AtRegularExpression, @"@[\\u4e00-\\u9fa5\\w\\-]+")

REGULAREXPRESSION_OPTION(PoundSignRegularExpression, @"#([^\\#|.]+)#", NSRegularExpressionCaseInsensitive|NSRegularExpressionDotMatchesLineSeparators)

REGULAREXPRESSION(EmojiRegularExpression, @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]")

#define kURLActionCount 5
NSString * const kURLActions[] = {@"url->",@"phoneNumber->",@"email->",@"at->",@"poundSign->"};

@interface MLEmojiLabel()<TTTAttributedLabelDelegate>


@end

@implementation MLEmojiLabel

/**
 *  TTT很鸡巴。commonInit是被调用了两回。如果直接init的话，因为init其中会调用initWithFrame
 *  回头建议修改
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.numberOfLines = 0;
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
        self.lineBreakMode = NSLineBreakByCharWrapping;
        
        //设置链接样式
        NSMutableDictionary *mutableLinkAttributes = [self.linkAttributes mutableCopy];
        [mutableLinkAttributes setValue:[NSNumber numberWithBool:NO] forKey:(__bridge NSString *)kCTUnderlineStyleAttributeName];
        [mutableLinkAttributes setValue:(__bridge id)[[UIColor colorWithRed:0.112 green:0.000 blue:0.791 alpha:1.000] CGColor] forKey:(__bridge NSString *)kCTForegroundColorAttributeName];
        self.linkAttributes = mutableLinkAttributes;
        
        //设置按下链接样式
        NSMutableDictionary *mutableActiveLinkAttributes = [self.activeLinkAttributes mutableCopy];
        [mutableActiveLinkAttributes setValue:(__bridge id)[[UIColor colorWithRed:0.112 green:0.000 blue:0.791 alpha:1.000] CGColor] forKey:(__bridge NSString *)kCTForegroundColorAttributeName];
        [mutableActiveLinkAttributes setValue:(__bridge id)[[UIColor colorWithWhite:0.631 alpha:1.000] CGColor] forKey:(NSString *)kTTTBackgroundFillColorAttributeName];
        self.activeLinkAttributes = mutableActiveLinkAttributes;

    }
    return self;
}

/**
 *  如果是有attributedText的情况下，有可能会返回少那么点的，这里矫正下
 *
 */
- (CGSize)sizeThatFits:(CGSize)size {
    if (!self.attributedText) {
        return [super sizeThatFits:size];
    }
    
    CGSize rSize = [super sizeThatFits:size];
    rSize.height +=1;
    return rSize;
}

- (void)setEmojiText:(NSString*)emojiText
{
    [self setText:emojiText];
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc]initWithString:emojiText];
    NSRange stringRange = NSMakeRange(0, mutableAttributedString.length);
    
    NSRegularExpression * const regexps[] = {kURLRegularExpression(),kPhoneNumerRegularExpression(),kEmailRegularExpression(),kAtRegularExpression(),kPoundSignRegularExpression()};
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSUInteger maxIndex = self.isNeedAtAndPoundSign?kURLActionCount:kURLActionCount-2;
    for (NSUInteger i=0; i<maxIndex; i++) {
        NSString *urlAction = kURLActions[i];
        [regexps[i] enumerateMatchesInString:[mutableAttributedString string] options:0 range:stringRange usingBlock:^(NSTextCheckingResult *result, __unused NSMatchingFlags flags, __unused BOOL *stop) {
            //添加链接
            NSString *actionString = [NSString stringWithFormat:@"%@%@",urlAction,[emojiText substringWithRange:result.range]];
            
            //这里暂时用NSTextCheckingTypeCorrection类型的传递消息吧
            //因为有自定义的类型出现，所以这样方便点。
            NSTextCheckingResult *aResult = [NSTextCheckingResult correctionCheckingResultWithRange:result.range replacementString:actionString];
            
            [results addObject:aResult];
        }];
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    //这里直接调用父类私有方法，好处能内部只会setNeedDisplay一次。一次更新所有添加的链接
    [super performSelector:@selector(addLinksWithTextCheckingResults:attributes:) withObject:results withObject:self.linkAttributes];
#pragma clang diagnostic pop
    
}


#pragma mark - delegate
- (void)attributedLabel:(TTTAttributedLabel *)label
didSelectLinkWithTextCheckingResult:(NSTextCheckingResult *)result;
{
    if (result.resultType == NSTextCheckingTypeCorrection) {
        //判断消息类型
        for (NSUInteger i=0; i<kURLActionCount; i++) {
            if ([result.replacementString hasPrefix:kURLActions[i]]) {
                NSString *content = [result.replacementString substringFromIndex:kURLActions[i].length];
                NSLog(@"%ld:%@",i,content);
            }
        }
    }
}


@end
