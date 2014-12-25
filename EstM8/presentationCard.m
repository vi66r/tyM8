//
//  presentationCard.m
//  EstM8
//
//  Created by Rafi Rizwan on 12/22/14.
//  Copyright (c) 2014 Rafi Rizwan. All rights reserved.
//

#import "presentationCard.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation presentationCard

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (instancetype)initWithPosition:(CGPoint)position andScreen:(CGRect)screen andTypeNum:(NSInteger)type andResults:(NSMutableDictionary *)results{
    self = [super initWithFrame: CGRectZero];
    NSArray *imageNames = @[@"dock.png",
                            @"clock.png",
                            @"graph.png",
                            @"tv.png",
                            @"analytics.png",
                            @"eye.png",
                            @"archive.png",
                            @"book.png"];
    self.frame = CGRectMake(position.x, position.y, screen.size.width-40, screen.size.height-128);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.shadowColor = [[UIColor clearColor] colorWithAlphaComponent:0.5].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 1.0f;
    self.layer.shadowRadius = 1.0f;
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[imageNames objectAtIndex:type]]];
    [image setFrame:CGRectMake(self.frame.size.width/2-60, self.frame.size.height/5-60, 120, 120)];
    [self addSubview:image];
    
    switch (type) {
        case 0:{
            int hours = [[results objectForKey:@"timeNoDistract"] intValue]/60/60;
            int minutes = [[results objectForKey:@"timeNoDistract"] intValue]/60%60;
            NSLog(@"test: %@", results);
            NSLog(@"QUE: %i", minutes);
            UILabel* topLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height/3, self.frame.size.width-40, 66)];
            if (hours == 1) {
                topLabel.text = [@"If you started now, it'd take you " stringByAppendingString:[[[NSString stringWithFormat:@"%i", hours] stringByAppendingString:@" hour and "] stringByAppendingString:[[NSString stringWithFormat:@"%i", minutes] stringByAppendingString:@" minutes."]]];
            } else {
                topLabel.text = [@"If you started now, it'd take you " stringByAppendingString:[[[NSString stringWithFormat:@"%i", hours] stringByAppendingString:@" hours and "] stringByAppendingString:[[NSString stringWithFormat:@"%i", minutes] stringByAppendingString:@" minutes."]]];
            }
            topLabel.font = [UIFont fontWithName:@"Avenir-Black" size:25];
            topLabel.textColor = UIColorFromRGB(0x03A9F4);
            topLabel.alpha = 1;
            topLabel.numberOfLines = 0;
            [topLabel sizeToFit];
            topLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:topLabel];
            NSNumber* words = [results objectForKey:@"numberOfWords"];
            NSNumber* paragraphs = [results objectForKey:@"numberOfParagraphs"];
            UILabel* bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height/3+topLabel.frame.size.height+15, self.frame.size.width-40, 66)];
            bottomLabel.text = [@"This essay will probably have around " stringByAppendingString:[[[words stringValue] stringByAppendingString:@" words and come out to about "] stringByAppendingString:[[paragraphs stringValue] stringByAppendingString:@" paragraphs."]]];
            bottomLabel.font = [UIFont fontWithName:@"Avenir-Black" size:25];
            bottomLabel.textColor = UIColorFromRGB(0x03A9F4);
            bottomLabel.alpha = 1;
            bottomLabel.numberOfLines = 0;
            [bottomLabel sizeToFit];
            bottomLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:bottomLabel];
            
        }
            break;
        case 1:{
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"hh:mm"];
            NSString *timeString = [formatter stringFromDate:[results objectForKey:@"canFinish"]];
            NSString *actualTimeString = [formatter stringFromDate:[results objectForKeyedSubscript:@"actualCanFinish"]];
            NSLog(@"test: %@", results);
            //NSLog(@"QUE: %i", minutes);
            UILabel* topLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height/3, self.frame.size.width-40, 66)];
            topLabel.text = [@"That means you should be done by " stringByAppendingString:[timeString stringByAppendingString:@"."]];
            topLabel.font = [UIFont fontWithName:@"Avenir-Black" size:25];
            topLabel.textColor = UIColorFromRGB(0x03A9F4);
            topLabel.alpha = 1;
            topLabel.numberOfLines = 0;
            [topLabel sizeToFit];
            topLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:topLabel];
            int hours = [[results objectForKey:@"timeToComplete"] intValue]/60/60;
            int minutes = [[results objectForKey:@"timeToComplete"] intValue]/60%60;
            NSLog(@"test: %@", results);
            NSLog(@"QUE: %i", minutes);
            UILabel* bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height/3+topLabel.frame.size.height+15, self.frame.size.width-40, 66)];
            if (hours == 1) {
                bottomLabel.text = [@"But life has its distractions, so it'll actually take you around " stringByAppendingString:[[[NSString stringWithFormat:@"%i", hours] stringByAppendingString:@" hour and "] stringByAppendingString:[[[[NSString stringWithFormat:@"%i", minutes] stringByAppendingString:@" minutes. So you'll actually finish around "] stringByAppendingString:actualTimeString] stringByAppendingString:@"."]]];
            } else {
                bottomLabel.text = [@"But life has its distractions, so it'll actually take you around " stringByAppendingString:[[[NSString stringWithFormat:@"%i", hours] stringByAppendingString:@" hours and "] stringByAppendingString:[[[[NSString stringWithFormat:@"%i", minutes] stringByAppendingString:@" minutes. So you'll actually finish around "] stringByAppendingString:actualTimeString] stringByAppendingString:@"."]]];
            }
            bottomLabel.font = [UIFont fontWithName:@"Avenir-Black" size:20];
            bottomLabel.textColor = UIColorFromRGB(0x03A9F4);
            bottomLabel.alpha = 1;
            bottomLabel.numberOfLines = 0;
            [bottomLabel sizeToFit];
            bottomLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:bottomLabel];
            
        }
            break;
        case 2:{
            int hours = [[results objectForKey:@"timeToResearchAndComplete"] intValue]/60/60;
            int minutes = [[results objectForKey:@"timeToResearchAndComplete"] intValue]/60%60;
            NSLog(@"test: %@", results);
            NSLog(@"QUE: %i", minutes);
            UILabel* topLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height/3, self.frame.size.width-40, 66)];
            if (hours == 1) {
                topLabel.text = [@"Unless you didn't do any research, in which case, for a paper of this size, it should take you " stringByAppendingString:[[[NSString stringWithFormat:@"%i", hours] stringByAppendingString:@" hour and "] stringByAppendingString:[[NSString stringWithFormat:@"%i", minutes] stringByAppendingString:@" minutes."]]];
            } else {
                topLabel.text = [@"Unless you didn't do any research, in which case, for a paper of this size, should take you " stringByAppendingString:[[[NSString stringWithFormat:@"%i", hours] stringByAppendingString:@" hours and "] stringByAppendingString:[[NSString stringWithFormat:@"%i", minutes] stringByAppendingString:@" minutes."]]];
            }
            topLabel.font = [UIFont fontWithName:@"Avenir-Black" size:25];
            topLabel.textColor = UIColorFromRGB(0x03A9F4);
            topLabel.alpha = 1;
            topLabel.numberOfLines = 0;
            [topLabel sizeToFit];
            topLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:topLabel];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"hh:mm"];
            NSString *timeString = [formatter stringFromDate:[results objectForKey:@"rtime"]];
            
            UILabel* bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, self.frame.size.height/3+topLabel.frame.size.height+15, self.frame.size.width-40, 66)];
            bottomLabel.text = [[@"You'll be able to finish by " stringByAppendingString:timeString] stringByAppendingString:@" if you start now."];
            bottomLabel.font = [UIFont fontWithName:@"Avenir-Black" size:20];
            bottomLabel.textColor = UIColorFromRGB(0x03A9F4);
            bottomLabel.alpha = 1;
            bottomLabel.numberOfLines = 0;
            [bottomLabel sizeToFit];
            bottomLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:bottomLabel];
            
            
        }
            break;
        case 3:{
            int hours = [[results objectForKey:@"facebook"] intValue]/60/60;
            int minutes = [[results objectForKey:@"facebook"] intValue]/60%60;
            NSLog(@"test: %@", results);
            NSLog(@"QUE: %i", minutes);
            UILabel* topLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height/3, self.frame.size.width-40, 66)];
            if (hours == 1) {
                topLabel.text = [@"For a paper of this size, the average person will end up spending " stringByAppendingString:[[[NSString stringWithFormat:@"%i", hours] stringByAppendingString:@" hour and "] stringByAppendingString:[[NSString stringWithFormat:@"%i", minutes] stringByAppendingString:@" minutes on Facebook, Buzzfeed, or Youtube."]]];
            } else {
                topLabel.text = [@"For a paper of this size, the average person will end up spending " stringByAppendingString:[[[NSString stringWithFormat:@"%i", hours] stringByAppendingString:@" hours and "] stringByAppendingString:[[NSString stringWithFormat:@"%i", minutes] stringByAppendingString:@" minutes on Facebook, Buzzfeed, or Youtube."]]];
            }
            topLabel.font = [UIFont fontWithName:@"Avenir-Black" size:25];
            topLabel.textColor = UIColorFromRGB(0x03A9F4);
            topLabel.alpha = 1;
            topLabel.numberOfLines = 0;
            [topLabel sizeToFit];
            topLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:topLabel];
        }
            break;
        case 4:{
            UILabel* topLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height/3, self.frame.size.width-40, 66)];
            topLabel.text = [[@"You'll burn about " stringByAppendingString:[[results objectForKey:@"calories"] stringValue]] stringByAppendingString:@" calories just typing this."];
            topLabel.font = [UIFont fontWithName:@"Avenir-Black" size:25];
            topLabel.textColor = UIColorFromRGB(0x03A9F4);
            topLabel.alpha = 1;
            topLabel.numberOfLines = 0;
            [topLabel sizeToFit];
            topLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:topLabel];
            NSNumber* coffee = [results objectForKey:@"coffee"];
            UILabel* bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height/3+topLabel.frame.size.height+15, self.frame.size.width-40, 66)];
            if ([coffee intValue] == 1) {
                bottomLabel.text = [@"And you'll probably need " stringByAppendingString:[[coffee stringValue] stringByAppendingString:@" cup of coffee to finish this."]];
            } else {
                bottomLabel.text = [@"And you'll probably need " stringByAppendingString:[[coffee stringValue] stringByAppendingString:@" cups of coffee to finish this."]];
            }
            bottomLabel.font = [UIFont fontWithName:@"Avenir-Black" size:25];
            bottomLabel.textColor = UIColorFromRGB(0x03A9F4);
            bottomLabel.alpha = 1;
            bottomLabel.numberOfLines = 0;
            [bottomLabel sizeToFit];
            bottomLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:bottomLabel];
            
        }
            
            break;
        case 5:
        {
            int read = [[results objectForKey:@"readtime"] intValue]/60;
            int proof = [[results objectForKey:@"proofread"] intValue]/60;
            UILabel* topLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height/3, self.frame.size.width-40, 66)];
            topLabel.text = [[@"This essay is going to take just about " stringByAppendingString:[NSString stringWithFormat:@"%i", read]] stringByAppendingString:@" minutes to read."];
            topLabel.font = [UIFont fontWithName:@"Avenir-Black" size:25];
            topLabel.textColor = UIColorFromRGB(0x03A9F4);
            topLabel.alpha = 1;
            topLabel.numberOfLines = 0;
            [topLabel sizeToFit];
            topLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:topLabel];
            UILabel* bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height/3+topLabel.frame.size.height+15, self.frame.size.width-40, 66)];
            bottomLabel.text = [[@"And around " stringByAppendingString:[NSString stringWithFormat:@"%i", proof]] stringByAppendingString:@" minutes to proofread."];
            bottomLabel.font = [UIFont fontWithName:@"Avenir-Black" size:25];
            bottomLabel.textColor = UIColorFromRGB(0x03A9F4);
            bottomLabel.alpha = 1;
            bottomLabel.numberOfLines = 0;
            [bottomLabel sizeToFit];
            bottomLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:bottomLabel];
            
        }
            break;
        case 6:{
            UILabel* topLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height/3, self.frame.size.width-40, 66)];
            topLabel.text = [[@"You should use about " stringByAppendingString:[[results objectForKey:@"sources"] stringValue]] stringByAppendingString:@" sources."];
            topLabel.font = [UIFont fontWithName:@"Avenir-Black" size:25];
            topLabel.textColor = UIColorFromRGB(0x03A9F4);
            topLabel.alpha = 1;
            topLabel.numberOfLines = 0;
            [topLabel sizeToFit];
            topLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:topLabel];
            UILabel* bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, self.frame.size.height/3+topLabel.frame.size.height+15, self.frame.size.width-40, 66)];
            bottomLabel.text = [[@"And " stringByAppendingString:[[results objectForKey:@"references"] stringValue]] stringByAppendingString:@" references in total."];
            bottomLabel.font = [UIFont fontWithName:@"Avenir-Black" size:25];
            bottomLabel.textColor = UIColorFromRGB(0x03A9F4);
            bottomLabel.alpha = 1;
            bottomLabel.numberOfLines = 0;
            [bottomLabel sizeToFit];
            bottomLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:bottomLabel];
        }
            break;

        default:
            break;
    }
    
    return self;
}

- (void)resetPosition:(CGPoint)toPosition onScreen:(CGRect)screen{
    self.frame = CGRectMake(toPosition.x, toPosition.y, screen.size.width-40, screen.size.height-128);
}

@end
