//
//  presentationCard.m
//  EstM8
//
//  Created by Rafi Rizwan on 12/22/14.
//  Copyright (c) 2014 Rafi Rizwan. All rights reserved.
//

#import "presentationCard.h"

@implementation presentationCard

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithPosition:(CGPoint)position andScreen:(CGRect)screen andTypeNum:(NSInteger)type{
    self = [super initWithFrame: CGRectZero];
    NSArray *imageNames = @[@"dock.png",
                            @"clock.png",
                            @"analytics.png",
                            @"tv.png",
                            @"graph.png",
                            @"coffee.png",
                            @"archive.png",
                            @"book.png"];
    self.frame = CGRectMake(position.x, position.y, screen.size.width-40, screen.size.height-128);
    self.backgroundColor = [UIColor greenColor];
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imageNames objectAtIndex:type]]];
    [image setFrame:CGRectMake(self.frame.size.width/2-60, self.frame.size.height/4-60, 120, 120)];
    [self addSubview:image];
    
    return self;
}

- (void)resetPosition:(CGPoint)toPosition onScreen:(CGRect)screen{
    self.frame = CGRectMake(toPosition.x, toPosition.y, screen.size.width-40, screen.size.height-128);
}

@end
