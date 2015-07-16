//
//  ViewController.m
//  MLEmojiLabel
//
//  Created by molon on 5/19/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import "ViewController.h"
#import "MLEmojiLabel.h"
#import "EmojiTableViewController.h"

@interface ViewController ()<MLEmojiLabelDelegate>

@property (nonatomic, strong) MLEmojiLabel *emojiLabel1;
@property (nonatomic, strong) MLEmojiLabel *emojiLabel2;
@property (nonatomic, strong) MLEmojiLabel *emojiLabel3;

@property (nonatomic, strong) UIImageView *textBackImageView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
#define kCommonWidth 250.0f
    [self.view addSubview:self.textBackImageView];
    [self.view addSubview:self.emojiLabel1];
    CGSize size = [self.emojiLabel1 preferredSizeWithMaxWidth:kCommonWidth];
    self.emojiLabel1.frame = CGRectMake(30, 64, kCommonWidth, size.height);
    
    CGRect backFrame = self.emojiLabel1.frame;
    backFrame.origin.x -= 18;
    backFrame.size.width += 18+10+5;
    backFrame.origin.y -= 13;
    backFrame.size.height += 13+13+7;
    self.textBackImageView.frame = backFrame;
    
    
    [self.view addSubview:self.emojiLabel2];
    size = [self.emojiLabel2 preferredSizeWithMaxWidth:kCommonWidth];
    //宽度少点用以触发省略号模式
    self.emojiLabel2.frame = CGRectMake(30, CGRectGetMaxY(self.emojiLabel1.frame)+30.0f, size.width-30.0f, size.height);
    
    [self.view addSubview:self.emojiLabel3];
    self.emojiLabel3.frame = CGRectMake(30, CGRectGetMaxY(self.emojiLabel2.frame)+30.0f, kCommonWidth, [self.emojiLabel3 preferredSizeWithMaxWidth:kCommonWidth].height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//这个是通常的用法
- (MLEmojiLabel *)emojiLabel1
{
    if (!_emojiLabel1) {
        _emojiLabel1 = [MLEmojiLabel new];
        _emojiLabel1.numberOfLines = 0;
        _emojiLabel1.font = [UIFont systemFontOfSize:15.0f];
        _emojiLabel1.delegate = self;
        _emojiLabel1.textAlignment = NSTextAlignmentLeft;
        _emojiLabel1.backgroundColor = [UIColor clearColor];
        _emojiLabel1.isNeedAtAndPoundSign = YES;
        //        _emojiLabel1.disableThreeCommon = YES;
        //        _emojiLabel1.disableEmoji = YES;
        
        _emojiLabel1.text = @"/:|-)TableView github:https://github.com/molon/MLEmojiLabel @撒旦 哈哈哈哈#九歌#九黎电话13612341234邮箱13612341234@qq.com旦旦/:dsad旦/::)sss/::~啊是大三的拉了/::B/::|/:8-)/::</::$/::X/::Z/::'(/::-|/::@/::P/::D/::O/::(/::+/:--b/::Q/::T/:,@P/:,@-D/::d/:,@o/::g/:|-)/::!/::L/::>/::,@/:,@f/::-S/:?/:ok/:love/:<L>/:jump/:shake/:<O>/:circle/:kotow/:turn/:skip/:oY链接:http://baidu.com dudl@qq.com";
        
        //测试TTT原生方法
        [_emojiLabel1 addLinkToURL:[NSURL URLWithString:@"http://sasasadan.com"] withRange:[_emojiLabel1.text rangeOfString:@"TableView"]];
        
        //这句测试剪切板
        [_emojiLabel1 performSelector:@selector(copy:) withObject:nil afterDelay:0.01f];
        
    }
    return _emojiLabel1;
}

//这个是自定义表情正则的用法
- (MLEmojiLabel *)emojiLabel2
{
    if (!_emojiLabel2) {
        _emojiLabel2 = [MLEmojiLabel new];
        _emojiLabel2.backgroundColor = [UIColor colorWithWhite:0.809 alpha:1.000];
        _emojiLabel2.numberOfLines = 1;
        
#warning 三种省略号模式下，NSLineBreakByTruncatingHead只会在numberOfLines为1的时候有效，numberOfLines为多行时候皆为NSLineBreakByTruncatingTail实现。NSLineBreakByTruncatingMiddle的话有问题，不允许使用。
        _emojiLabel2.lineBreakMode = NSLineBreakByTruncatingHead;
        _emojiLabel2.font = [UIFont systemFontOfSize:14.0f];
        
        //下面是自定义表情正则和图像plist的例子
        _emojiLabel2.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
        _emojiLabel2.customEmojiPlistName = @"expressionImage_custom";
        _emojiLabel2.text = @"微笑[微笑][白眼][白眼][白眼][白眼]微笑[愉快][冷汗][投降]";
    }
    return _emojiLabel2;
}

//这个是设置NSAttrbuteString的用法
- (MLEmojiLabel *)emojiLabel3
{
    if (!_emojiLabel3) {
        _emojiLabel3 = [MLEmojiLabel new];
        _emojiLabel3.backgroundColor = [UIColor colorWithRed:0.218 green:0.809 blue:0.304 alpha:1.000];
        _emojiLabel3.numberOfLines = 0;
        _emojiLabel3.font = [UIFont systemFontOfSize:14.0f];
        _emojiLabel3.textColor = [UIColor whiteColor];
        
        NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:@"\
对潇潇暮雨洒江天，一番洗清秋。 \
渐霜风凄紧，关河冷落，残照当楼。 \
是处红衰翠减，苒苒物华休。 \
惟有长江水，无语东流。 \
不忍登高临远，望故乡渺邈，归思难收。 \
叹年来踪迹，何事苦淹留。 \
想佳人、妆楼颙望，误几回、天际识归舟。\
争知我、倚阑干处，正恁凝愁"];
        
        //注意以下俩属性会被覆盖，原因参见下面注释
        [attString addAttribute:(NSString *)kCTForegroundColorAttributeName value:[UIColor colorWithRed:0.080 green:0.122 blue:0.258 alpha:1.000] range:NSMakeRange(9, 5)];
        [attString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0f] range:NSMakeRange(9, 5)];
        
        /*
         切记:
         1.通过setText方法直接设置NSAttributeString的话，label的默认属性不会启用的(label的font textColor lineSpacing kern等等),需要手动添加，具体手动添加方法请参见TTTAttributedLabel的NSAttributedStringAttributesFromLabel方法。
         2.通过setText:afterInheritingLabelAttributesAndConfiguringWithBlock:设置NSAttributeString的话，label的默认属性都能添加上去，但是之前已经有的属性可能会被覆盖，例如上面这句给range 9，5添加的属性会被覆盖(PS:ios8下会被覆盖)
         以上两点，请酌情使用。有很大必要的时候本人再想办法处理成通用更友好的体验，但是一般情况下觉得没太大必要，毕竟像TTT这么流行的库，也存在这个问题没有处理。
         */
#warning 切记以上两点
#warning 这里注意参数也可以为NSString，然后block里添加需要的Attribute。
#warning tips，刚刚发现在此block里 iOS8下不支持NSForegroundColorAttributeName属性，请使用kCTForegroundColorAttributeName
        [_emojiLabel3 setText:attString afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
            [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:[UIColor colorWithRed:0.313 green:0.479 blue:1.000 alpha:1.000] range:NSMakeRange(0, 4)];
            
            [mutableAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0f] range:NSMakeRange(22, 4)];
            [mutableAttributedString addAttribute:(NSString *)kCTForegroundColorAttributeName value:[UIColor colorWithRed:0.627 green:0.374 blue:0.219 alpha:1.000] range:NSMakeRange(22, 4)];
            return mutableAttributedString;
        }];
    }
    return _emojiLabel3;
}

- (UIImageView *)textBackImageView
{
    if (!_textBackImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [[UIImage imageNamed:@"ReceiverTextNodeBkg_ios7"]resizableImageWithCapInsets:UIEdgeInsetsMake(28, 18, 25, 10)] ;
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.clipsToBounds = YES;
        
        _textBackImageView = imageView;
    }
    return _textBackImageView;
}

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

- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"点击了某个自添加链接%@",url);
    
    EmojiTableViewController *vc = [EmojiTableViewController new];
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
}

@end
