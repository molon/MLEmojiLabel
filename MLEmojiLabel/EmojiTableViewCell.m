//
//  EmojiTableViewCell.m
//  MLEmojiLabel
//
//  Created by molon on 9/2/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import "EmojiTableViewCell.h"
#import "MLEmojiLabel.h"

#define kWidth 300.0f
@interface EmojiTableViewCell()<MLEmojiLabelDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) MLEmojiLabel *emojiLabel;

@end

@implementation EmojiTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:self.emojiLabel];
        
#warning 这里是在父View添加手势后，不影响emojiLabel的链接点击的范例，参考下面的gestureRecognizer:shouldReceiveTouch:方法内实现
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        tapG.delegate = self;
        [self.contentView addGestureRecognizer:tapG];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [self.contentView addSubview:self.emojiLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)tap
{
    NSLog(@"tapped");
}

#pragma mark - gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return ![self.emojiLabel containslinkAtPoint:[touch locationInView:self.emojiLabel]];
}

#pragma mark - getter
- (MLEmojiLabel *)emojiLabel
{
    if (!_emojiLabel) {
        _emojiLabel = [MLEmojiLabel new];
        _emojiLabel.numberOfLines = 0;
        _emojiLabel.font = [UIFont systemFontOfSize:14.0f];
        _emojiLabel.delegate = self;
        _emojiLabel.backgroundColor = [UIColor clearColor];
        _emojiLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _emojiLabel.textColor = [UIColor whiteColor];
        _emojiLabel.backgroundColor = [UIColor colorWithRed:0.218 green:0.809 blue:0.304 alpha:1.000];
        
        _emojiLabel.textInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _emojiLabel.isNeedAtAndPoundSign = YES;
        _emojiLabel.disableEmoji = NO;
        
        _emojiLabel.lineSpacing = 3.0f;
        
        _emojiLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
        
//        _emojiLabel.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
//        _emojiLabel.customEmojiPlistName = @"expressionImage_custom.plist";
    }
    return _emojiLabel;
}


#pragma mark - setter
- (void)setEmojiText:(NSString *)emojiText
{
    _emojiText = emojiText;
    
    [self.emojiLabel setText:emojiText];
}

#pragma mark - height
+ (CGFloat)heightForEmojiText:(NSString*)emojiText
{
    static MLEmojiLabel *protypeLabel = nil;
    if (!protypeLabel) {
        protypeLabel = [MLEmojiLabel new];
        protypeLabel.numberOfLines = 0;
        protypeLabel.font = [UIFont systemFontOfSize:14.0f];
        protypeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        protypeLabel.textInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        protypeLabel.isNeedAtAndPoundSign = YES;
        protypeLabel.disableEmoji = NO;
        protypeLabel.lineSpacing = 3.0f;
        
        protypeLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentCenter;
        
//        protypeLabel.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
//        protypeLabel.customEmojiPlistName = @"expressionImage_custom.plist";
    }
    
    [protypeLabel setText:emojiText];

    return [protypeLabel preferredSizeWithMaxWidth:kWidth].height+5.0f*2;
}

#pragma mark - layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.emojiLabel.frame = CGRectMake(10.0f, 5.0f, kWidth, self.contentView.frame.size.height-5.0f*2);
}

#pragma mark - delegate
- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    switch(type){
        case MLEmojiLabelLinkTypeURL:
            NSLog(@"点击了链接%@",link);
            break;
        case MLEmojiLabelLinkTypePhoneNumber:
            NSLog(@"点击了电话%@",link);
            break;
        case MLEmojiLabelLinkTypeEmail:
            NSLog(@"点击了邮箱%@",link);
            break;
        case MLEmojiLabelLinkTypeAt:
            NSLog(@"点击了用户%@",link);
            break;
        case MLEmojiLabelLinkTypePoundSign:
            NSLog(@"点击了话题%@",link);
            break;
        default:
            NSLog(@"点击了不知道啥%@",link);
            break;
    }
    
}
@end
