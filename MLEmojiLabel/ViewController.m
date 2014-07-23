//
//  ViewController.m
//  MLEmojiLabel
//
//  Created by molon on 5/19/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import "ViewController.h"
#import "MLEmojiLabel.h"

@interface ViewController ()<MLEmojiLabelDelegate>

@property (nonatomic, strong) MLEmojiLabel *emojiLabel;

@property (nonatomic, strong) UIImageView *textBackImageView;

@property (nonatomic, strong) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.textBackImageView];
    [self.view addSubview:self.emojiLabel];
    self.emojiLabel.frame = CGRectMake(50, 100, 250, 100);
    [self.emojiLabel sizeToFit];
    
    CGRect backFrame = self.emojiLabel.frame;
    backFrame.origin.x -= 18;
    backFrame.size.width += 18+10+5;
    backFrame.origin.y -= 13;
    backFrame.size.height += 13+13+7;
    self.textBackImageView.frame = backFrame;
    
    //        [self.view addSubview:self.label];
    //        self.label.frame = CGRectMake(50, 250, 250, 100);
    //        [self.label sizeToFit];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MLEmojiLabel *)emojiLabel
{
	if (!_emojiLabel) {
        _emojiLabel = [[MLEmojiLabel alloc]init];
        _emojiLabel.numberOfLines = 0;
        _emojiLabel.font = [UIFont systemFontOfSize:14.0f];
        NSLog(@"%f",_emojiLabel.font.lineHeight);
        _emojiLabel.emojiDelegate = self;
        //        _emojiLabel.textAlignment = NSTextAlignmentCenter;
        _emojiLabel.backgroundColor = [UIColor clearColor];
        _emojiLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _emojiLabel.isNeedAtAndPoundSign = YES;
        
        //        _emojiLabel.disableThreeCommon = YES;
        //        _emojiLabel.disableEmoji = YES;
        
                [_emojiLabel setEmojiText:@"撒萨撒旦撒旦撒达说https://github.com/molon/MLEmojiLabel阿苏打@撒旦 哈哈哈哈#撒asd#撒旦撒电话18120136012邮箱dudl@qq.com旦旦/:dsad旦/::)sss/::~啊是大三的/::B/::|/:8-)/::</::$/::X/::Z/::'(/::-|/::@/::P/::D/::O/::(/::+/:--b/::Q/::T/:,@P/:,@-D/::d/:,@o/::g/:|-)/::!/::L/::>/::,@/:,@f/::-S/:?/:,@x/:,@@/::8/:,@!/:!!!/:xx/:bye/:wipe/:dig/:handclap/:&-(/:B-)/:<@/:@>/::-O/:>-|/:P-(/::'|/:X-)/::*/:@x/:8*/:pd/:<W>/:beer/:basketb/:oo/:coffee/:eat/:pig/:rose/:fade/:showlovesssff/:heart/:break/:cake/:li/:bome/:kn/:footb/:ladybug/:shit/:moon/:sun/:gift/:hug/:strong/:weak/:share/:v/:@)/:jj/:@@/:bad/:lvu/:no/:ok/:love/:<L>/:jump/:shake/:<O>/:circle/:kotow/:turn/:skip/:oY链接:http://baidu.com拉了dudl@qq.com"];
        
        
//        _emojiLabel.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
//        _emojiLabel.customEmojiPlistName = @"expressionImage_custom.plist";
//        //                [_emojiLabel setEmojiText:@"微笑[微笑][白眼][白眼][白眼][白眼]微笑[愉快]---[冷汗][投降][抓狂][害羞]"];
//        [_emojiLabel setEmojiText:@"[微笑]-[撇嘴]-[色]-[发呆][得意]-[流泪][害羞][闭嘴][睡][大哭][尴尬]-[发怒]-[调皮][呲牙][惊讶][难过][酷]-[冷汗]-[抓狂][吐][偷笑][愉快][白眼][傲慢][饥饿][困][惊恐][流汗][憨笑][悠闲][奋斗][咒骂][疑问][嘘][晕][疯了][衰][骷髅][敲打][再见][擦汗][抠鼻][鼓掌][糗大了][坏笑][左哼哼][右哼哼][哈欠][鄙视][委屈][快哭了][阴险][亲亲][吓][可怜][菜刀][西瓜][啤酒][篮球][乒乓][咖啡][饭][猪头][玫瑰][凋谢][嘴唇][爱心][心碎][蛋糕][闪电][炸弹][刀][足球][瓢虫][便便][月亮][太阳][礼物][拥抱][强][弱][握手][胜利][抱拳][勾引][拳头][差劲][爱你][NO][OK][爱情][飞吻][跳跳][发抖][怄火][转圈][磕头][回头][跳绳][投降]"];
    }
	return _emojiLabel;
}

- (UILabel *)label
{
    if (!_label) {
        UILabel* label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.lineBreakMode = NSLineBreakByCharWrapping;
        label.numberOfLines = 0;
        label.text = @"链接:http://baidu.com电话18120136012邮箱dudl@qq.com@某某某 ,###哈哈哈### ,[大笑] 啊是大三的@阿萨德.com";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text ];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:5.0];
        [paragraphStyle setLineBreakMode:NSLineBreakByCharWrapping];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [label.text length])];
        
        label.attributedText = attributedString;
        
        _label = label;
    }
    return _label;
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
@end
