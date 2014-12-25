//
//  dateParser.m
//  EstM8
//
//  Created by Rafi Rizwan on 12/21/14.
//  Copyright (c) 2014 Rafi Rizwan. All rights reserved.
//

#import "dateParser.h"

@interface dateParser()

@end

@implementation dateParser

- (NSDate*) parseStringToDueDate:(NSString*) inputString withTimeString:(NSString *)inputTimeString{
    NSDate *dueDate = [NSDate dateWithTimeIntervalSince1970:2];
    
    NSArray *stringComponents = [inputString componentsSeparatedByString:@" "];
    NSArray *timeStringComponents = [inputTimeString componentsSeparatedByString:@" "];
    NSMutableArray *hoursAndMinutes = [[[timeStringComponents objectAtIndex:0] componentsSeparatedByString:@":"] mutableCopy];
    
    if ([hoursAndMinutes count] == 1) {
        [hoursAndMinutes addObject:@"00"];
    }
    
    if ([timeStringComponents count] > 1) {
        if ([[[timeStringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"pm"] && [[hoursAndMinutes objectAtIndex:0] intValue] > 12) {
            NSString* replacement = [NSString stringWithFormat:@"%f", [[hoursAndMinutes objectAtIndex:0] doubleValue]+12];
            [hoursAndMinutes replaceObjectAtIndex:0 withObject:replacement];
        } else if([[[timeStringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"pm"] && [[hoursAndMinutes objectAtIndex:0] intValue] == 12) {
            NSString* replacement = @"00";
            [hoursAndMinutes replaceObjectAtIndex:0 withObject:replacement];
        }
    }
    
    switch ([stringComponents count]) {
        case 1:{
            // do something
            NSDate *now = [NSDate date];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit fromDate:now];
            
            if ([[[stringComponents objectAtIndex:0] lowercaseString] isEqualToString:@"tonight"] || [[[stringComponents objectAtIndex:0] lowercaseString] isEqualToString:@"today"]) {
                
                if ([timeStringComponents count] > 1) {
                    if ([[[timeStringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"am"]) {
                        NSInteger day = [components weekday] + 1;
                    } else {
                        dueDate = now;
                    }
                } else {
                    dueDate = now;
                }
                
            } else if([[[stringComponents objectAtIndex:0] lowercaseString] isEqualToString:@"tomorrow"]){
                if ([timeStringComponents count] > 1) {
                    if ([[[timeStringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"am"]) {
                        NSInteger day = [components weekday] + 2;
                        dueDate = [NSDate dateWithTimeIntervalSinceNow:86400];
                    } else {
                        dueDate = [NSDate dateWithTimeIntervalSinceNow:86400];

                    }
                } else {
                        dueDate = [NSDate dateWithTimeIntervalSinceNow:86400];

                }
            }
            
            if ([[[stringComponents objectAtIndex:0] lowercaseString] isEqualToString:@"monday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (9 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else if ([[[stringComponents objectAtIndex:0] lowercaseString] isEqualToString:@"tuesday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (10 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else if ([[[stringComponents objectAtIndex:0] lowercaseString] isEqualToString:@"wednesday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (11 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else if ([[[stringComponents objectAtIndex:0] lowercaseString] isEqualToString:@"thursday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (12 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else if ([[[stringComponents objectAtIndex:0] lowercaseString] isEqualToString:@"friday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (13 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else if ([[[stringComponents objectAtIndex:0] lowercaseString] isEqualToString:@"saturday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (14 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else if ([[[stringComponents objectAtIndex:0] lowercaseString] isEqualToString:@"sunday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (8 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else {
                // nada
            }
            
            NSDateComponents *componentFinal = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSCalendarUnitDay fromDate:dueDate];
            [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            
            NSLog(@"%@",[NSTimeZone localTimeZone]);
            
            [componentFinal setHour:[[hoursAndMinutes objectAtIndex:0] integerValue]];
            [componentFinal setMinute:[[hoursAndMinutes objectAtIndex:1] integerValue]];
            [componentFinal setSecond:0];
            
            dueDate = [calendar dateFromComponents:componentFinal];
        }
            break;
        case 2:{
            // do something else
            if ([[[stringComponents objectAtIndex:0]lowercaseString] isEqualToString:@"next"]) {
                NSDate *now = [NSDate date];
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit fromDate:now];
                
                if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"monday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (9 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"tuesday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (10 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"wednesday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (11 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"thursday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (12 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"friday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (13 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"saturday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (14 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"sunday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (8 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"week"]){
                    dueDate = [now dateByAddingTimeInterval:60*60*24*7];
                }
                
                NSDateComponents *componentFinal = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSCalendarUnitDay fromDate:dueDate];
                [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
                
                NSLog(@"%@",[NSTimeZone localTimeZone]);

                
                [componentFinal setHour:[[hoursAndMinutes objectAtIndex:0] integerValue]];
                [componentFinal setMinute:[[hoursAndMinutes objectAtIndex:1] integerValue]];
                [componentFinal setSecond:0];
                
                dueDate = [calendar dateFromComponents:componentFinal];

            } else {
                return nil;
            }
        }
            break;
        case 3:
            return nil;
            break;
        
        case 4:
            return nil;
            break;
            
        case 5:
            if ([[[stringComponents objectAtIndex:0] lowercaseString] isEqualToString:@"the"]) {
                if ([[[stringComponents objectAtIndex:2] lowercaseString] isEqualToString:@"after"]) {
                    if ([[[stringComponents objectAtIndex:4] lowercaseString] isEqualToString:@"next"]) {
                        NSDate *now = [NSDate date];
                        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                        NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit fromDate:now];
                        
                        if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"monday"]) {
                            
                            NSUInteger weekdayToday = [components weekday];
                            NSInteger daysToMonday = (9 - weekdayToday) % 7;
                            
                            dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday+(60*60*24*7)];
                        } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"tuesday"]) {
                            
                            NSUInteger weekdayToday = [components weekday];
                            NSInteger daysToMonday = (10 - weekdayToday) % 7;
                            
                            dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday+(60*60*24*7)];
                        } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"wednesday"]) {
                            
                            NSUInteger weekdayToday = [components weekday];
                            NSInteger daysToMonday = (11 - weekdayToday) % 7;
                            
                            dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday+(60*60*24*7)];
                        } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"thursday"]) {
                            
                            NSUInteger weekdayToday = [components weekday];
                            NSInteger daysToMonday = (12 - weekdayToday) % 7;
                            
                            dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday+(60*60*24*7)];
                        } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"friday"]) {
                            
                            NSUInteger weekdayToday = [components weekday];
                            NSInteger daysToMonday = (13 - weekdayToday) % 7;
                            
                            dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday+(60*60*24*7)];
                        } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"saturday"]) {
                            
                            NSUInteger weekdayToday = [components weekday];
                            NSInteger daysToMonday = (14 - weekdayToday) % 7;
                            
                            dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday+(60*60*24*7)];
                        } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"sunday"]) {
                            
                            NSUInteger weekdayToday = [components weekday];
                            NSInteger daysToMonday = (8 - weekdayToday) % 7;
                            
                            dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday+(60*60*24*7)];
                        } else if ([[[stringComponents objectAtIndex:1] lowercaseString] isEqualToString:@"week"]){
                            dueDate = [now dateByAddingTimeInterval:60*60*24*7*2];
                        }
                        
                        NSDateComponents *componentFinal = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSCalendarUnitDay fromDate:dueDate];
                        [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
                        
                        NSLog(@"%@",[NSTimeZone localTimeZone]);
                        
                        
                        [componentFinal setHour:[[hoursAndMinutes objectAtIndex:0] integerValue]];
                        [componentFinal setMinute:[[hoursAndMinutes objectAtIndex:1] integerValue]];
                        [componentFinal setSecond:0];
                        
                        dueDate = [calendar dateFromComponents:componentFinal];
                    }
                }
            }
            break;
            
        default:
            return nil;
            break;
    }
    
    return dueDate;
}

@end

