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

- (NSDate*) parseStringToDueDate:(NSString*) inputString{
    NSDate *dueDate = [NSDate dateWithTimeIntervalSince1970:2];
    
    NSArray *stringComponents = [inputString componentsSeparatedByString:@" "];
    
    switch ([stringComponents count]) {
        case 1:{
            // do something
            if ([[stringComponents objectAtIndex:0] isEqualToString:@"tonight"]) {
                dueDate = [NSDate dateWithTimeIntervalSinceNow:86400];
            }
            
            NSDate *now = [NSDate date];
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit fromDate:now];
            
            if ([[[[stringComponents objectAtIndex:0] stringValue] lowercaseString] isEqualToString:@"monday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (9 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else if ([[[[stringComponents objectAtIndex:0] stringValue] lowercaseString] isEqualToString:@"tuesday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (10 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else if ([[[[stringComponents objectAtIndex:0] stringValue] lowercaseString] isEqualToString:@"wednesday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (11 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else if ([[[[stringComponents objectAtIndex:0] stringValue] lowercaseString] isEqualToString:@"thursday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (12 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else if ([[[[stringComponents objectAtIndex:0] stringValue] lowercaseString] isEqualToString:@"friday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (13 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else if ([[[[stringComponents objectAtIndex:0] stringValue] lowercaseString] isEqualToString:@"saturday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (14 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else if ([[[[stringComponents objectAtIndex:0] stringValue] lowercaseString] isEqualToString:@"sunday"]) {
                
                NSUInteger weekdayToday = [components weekday];
                NSInteger daysToMonday = (8 - weekdayToday) % 7;
                
                dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
            } else {
                // nada
            }
        }
            break;
        case 2:{
            // do something else
            if ([[[[stringComponents objectAtIndex:0]stringValue]lowercaseString] isEqualToString:@"next"]) {
                NSDate *now = [NSDate date];
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit fromDate:now];
                
                if ([[[[stringComponents objectAtIndex:1] stringValue] lowercaseString] isEqualToString:@"monday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (9 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[[stringComponents objectAtIndex:1] stringValue] lowercaseString] isEqualToString:@"tuesday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (10 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[[stringComponents objectAtIndex:1] stringValue] lowercaseString] isEqualToString:@"wednesday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (11 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[[stringComponents objectAtIndex:1] stringValue] lowercaseString] isEqualToString:@"thursday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (12 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[[stringComponents objectAtIndex:1] stringValue] lowercaseString] isEqualToString:@"friday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (13 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[[stringComponents objectAtIndex:1] stringValue] lowercaseString] isEqualToString:@"saturday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (14 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else if ([[[[stringComponents objectAtIndex:1] stringValue] lowercaseString] isEqualToString:@"sunday"]) {
                    
                    NSUInteger weekdayToday = [components weekday];
                    NSInteger daysToMonday = (8 - weekdayToday) % 7;
                    
                    dueDate = [now dateByAddingTimeInterval:60*60*24*daysToMonday];
                } else {
                    // nada
                }

            }
        }
            break;
        case 3:
            // do something even more
            break;
            
        default:
            break;
    }
    
    return dueDate;
}

@end
