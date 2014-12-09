//
//  EmojiTableViewCell.h
//  MLEmojiLabel
//
//  Created by molon on 9/2/14.
//  Copyright (c) 2014 molon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmojiTableViewCell : UITableViewCell

@property (nonatomic, copy) NSString *emojiText;

+ (CGFloat)heightForEmojiText:(NSString*)emojiText;

@end
