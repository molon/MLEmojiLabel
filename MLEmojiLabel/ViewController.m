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
    
        [self.view addSubview:self.label];
        self.label.frame = CGRectMake(50, 250, 250, 100);
        [self.label sizeToFit];
    
    
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
        _emojiLabel.isNeedAtAndPoundSign = YES;
		[_emojiLabel setEmojiText:@"链接:http://baidu.com电话18120136012邮箱dudl@qq.com@某某某 ,###哈哈哈### ,[大笑] 啊是大三的@阿萨德.com@dsad@dad"];
        _emojiLabel.emojiDelegate = self;
        
        _emojiLabel.backgroundColor = [UIColor clearColor];
        _emojiLabel.lineBreakMode = NSLineBreakByCharWrapping;
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
