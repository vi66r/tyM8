//
//  dateParser.h
//  EstM8
//
//  Created by Rafi Rizwan on 12/21/14.
//  Copyright (c) 2014 Rafi Rizwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dateParser : NSObject

@property (strong, nonatomic) NSString* dateToParse;

- (NSDate*) parseStringToDueDate:(NSString*) inputString;

@end
