//
//  EmojiTableViewController.m
//  MLEmojiLabel
//
//  Created by molon on 9/2/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import "EmojiTableViewController.h"
#import "EmojiTableViewCell.h"

//#define kTempText @"[微笑]-[撇嘴]-[色]-[发呆][得意]-[流泪][害羞][闭嘴][睡][大哭][尴尬]-[发怒]-[调皮][呲牙][惊讶][难过][酷]-[冷汗]-[抓狂][吐][偷笑][愉快][白眼][傲慢][饥饿][困][惊恐][流汗][憨笑][悠闲][奋斗][咒骂][疑问][嘘][晕][疯了][衰][骷髅][敲打][再见][擦汗][抠鼻][鼓掌][糗大了][坏笑][左哼哼][右哼哼][哈欠][鄙视][委屈][快哭了][阴险][亲亲][吓][可怜][菜刀][西瓜][啤酒][篮球][乒乓][咖啡][饭][猪头][玫瑰][凋谢][嘴唇][爱心][心碎][蛋糕][闪电][炸弹][刀][足球][瓢虫][便便][月亮][太阳][礼物][拥抱][强][弱][握手][胜利][抱拳][勾引][拳头][差劲][爱你][NO][OK][爱情][飞吻][跳跳][发抖][怄火][转圈][磕头][回头][跳绳][投降]"
#define kTempText @"github:https://github.com/molon/MLEmojiLabel @撒旦 哈哈哈哈#九歌#九黎电话13612341234邮箱13612341234@qq.com旦旦/:dsad旦/::)sss/::~啊是大三的拉了/::B/::|/:8-)/::</::$/::X/::Z/::'(啊是大三的拉了/::-|/::@/::P/::D/::/:skip/:oY链接:http://baidu.com dudl@qq.com"
//
//#define kTempText @"风头痛医头让人头疼头疼如同讨厌团团圆圆天然淘汰讨厌雨天豚蹄穰田一样天堂与 u 回归饭否风格很尴尬头痛欲也一天天一个个 vv 哈哈一天图 u 音乐体育 u体育一条条鱼 u 一天宇 u 一样讨厌 vv 提供蝇营狗苟 v 还有哥哥 vvv刚刚蝇营狗苟 vv 关于狗狗 vv 关于狗狗 v 哈哈刚刚国画家哈哈巩固与提高规划和规范体育 u 哈哈刚刚过红红火火官方广告红红火火哥哥哥哥耿耿于怀哈哈给哥哥哥哥给哥哥哥哥红红火火家回家好好改革和关怀和改革规划红红火火哥哥哥哥哈哈刚刚共和国哥哥哥哥给哥哥哥哥哥哥哥哥刚刚更换很好过分服服帖帖也一样天天体育与 iiiuu 艳阳天天堂突然头痛头痛人突然突然突然突然有一天天让团团圆圆突然让他隐隐约约吞吞吐吐听听英语莺啼燕语一天玉渊潭玉渊潭玉渊潭玉渊潭一样通用语言体育有天堂与一天天英语 u天堂与 uu 也一样头痛头痛头痛头痛头痛头痛头痛头痛头痛忐忑噩噩噩噩噩人人人人吞吞吐吐www.baidu.com突然让人太突然突然头痛头痛他突然头痛头痛柔软天然天然13488640661天然天然头痛头痛头痛头痛头痛头痛头痛头痛头痛头痛头痛头痛头痛头痛头痛他吞吞"
@interface EmojiTableViewController ()

@end

@implementation EmojiTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Uncomment the following line to preserve selection between presentations.
    
    self.title = @"TableView Test";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dismiss
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"reuseIdentifier";
    EmojiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[EmojiTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (![cell.emojiText isEqualToString:kTempText]) {
        cell.emojiText = kTempText;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EmojiTableViewCell heightForEmojiText:kTempText];
}

@end
