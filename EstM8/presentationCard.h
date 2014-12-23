//
//  presentationCard.h
//  EstM8
//
//  Created by Rafi Rizwan on 12/22/14.
//  Copyright (c) 2014 Rafi Rizwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface presentationCard : UIView

@property (strong, nonatomic) NSMutableDictionary* results;
//@property (strong, nonatomic) UIImage* image;
@property (nonatomic) NSInteger typeNum;

- (instancetype)initWithPosition:(CGPoint)position andScreen:(CGRect)screen andTypeNum:(NSInteger)type;
- (void)resetPosition:(CGPoint)toPosition onScreen:(CGRect)screen;

@end
