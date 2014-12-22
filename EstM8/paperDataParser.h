//
//  paperDataParser.h
//  EstM8
//
//  Created by Rafi Rizwan on 12/21/14.
//  Copyright (c) 2014 Rafi Rizwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface paperDataParser : NSObject

- (NSMutableDictionary*) getPageStatsBasedWithNumberOfPages:(double) numberOfPages andDate:(NSDate*) dueDate;

@end
