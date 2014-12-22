//
//  paperDataParser.m
//  EstM8
//
//  Created by Rafi Rizwan on 12/21/14.
//  Copyright (c) 2014 Rafi Rizwan. All rights reserved.
//

#import "paperDataParser.h"

@implementation paperDataParser

- (NSMutableDictionary*) getPageStatsBasedWithNumberOfPages:(double) numberOfPages andDate:(NSDate*) dueDate{
    NSMutableDictionary* results = [[NSMutableDictionary alloc] init];
    

    
    double wordsPerPage = 231;
    double numberOfWords = numberOfPages * wordsPerPage;
    int judgementOfLength = 0;
    
    NSString *canYouDoIt = @"";
    
    if(numberOfWords<=wordsPerPage/2){
        judgementOfLength=0;//less than 1/2
    }else if(numberOfWords>wordsPerPage/2&&numberOfWords<=wordsPerPage*2){
        judgementOfLength=0;//between 1/2 and 2
    }else if(numberOfWords>wordsPerPage*2&&numberOfWords<=wordsPerPage*5){
        judgementOfLength=1;//between 2 and 5
    }else if(numberOfWords>wordsPerPage*5&&numberOfWords<=wordsPerPage*10){
        judgementOfLength=2;//between 5 and 10
    }else if(numberOfWords>wordsPerPage*10&&numberOfWords<=wordsPerPage*25){
        judgementOfLength=3;//between 10 and 25
    }else if(numberOfWords>wordsPerPage*25&&numberOfWords<=wordsPerPage*45){
        judgementOfLength=4;//between 25 and 45
    }else{
        judgementOfLength=5;//over 45
    }
    
    NSLog(@"%i", judgementOfLength);
    
    NSDate *now = [NSDate date];
    NSTimeInterval timeLeft = [dueDate timeIntervalSinceDate:now];
    NSLog(@"you have this much time left: %f", timeLeft);
    
    timeLeft = timeLeft/60/60;
    
    if (timeLeft <= 1) {
        switch (judgementOfLength) {
            case 0:
                canYouDoIt = @"...good luck buddy.";
                break;
            case 1:
                canYouDoIt = @"90% chance this isn't happening";
                break;
            case 2:
                canYouDoIt = @"nope.";
                break;
            case 3:
                canYouDoIt = @"nope.";
                break;
            case 4:
                canYouDoIt = @"nope.";
                break;
            case 5:
                canYouDoIt = @"nope.";
                break;
            default:
                canYouDoIt = @"nope.";
                break;
        }
    } else if (timeLeft > 1 && timeLeft <= 3){
        switch (judgementOfLength) {
            case 0:
                canYouDoIt = @"you might get lucky...";
                break;
            case 1:
                canYouDoIt = @"you're going to need the odds to really be in your favor";
                break;
            case 2:
                canYouDoIt = @"\"fat chance. lolz.\"";
                break;
            case 3:
                canYouDoIt = @"nope.";
                break;
            case 4:
                canYouDoIt = @"nope.";
                break;
            case 5:
                canYouDoIt = @"nope.";
                break;
            default:
                canYouDoIt = @"nope.";
                break;
        }
    }else if(timeLeft > 3 && timeLeft <= 5){
        switch (judgementOfLength) {
            case 0:
                canYouDoIt = @"you should buckle down and concetrate.";
                break;
            case 1:
                canYouDoIt = @"there's still a chance.";
                break;
            case 2:
                canYouDoIt = @"this venture is not likely to succeed.";
                break;
            case 3:
                canYouDoIt = @"nope.";
                break;
            case 4:
                canYouDoIt = @"nope.";
                break;
            case 5:
                canYouDoIt = @"nope.";
                break;
            default:
                canYouDoIt = @"nope.";
                break;
        }
    }else if(timeLeft > 5 && timeLeft <= 10){
        switch (judgementOfLength) {
            case 0:
                canYouDoIt = @"you can do this.";
                break;
            case 1:
                canYouDoIt = @"you can do this.";
                break;
            case 2:
                canYouDoIt = @"you may actually be able to pull it off.";
                break;
            case 3:
                canYouDoIt = @"concentrate. No breaks.";
                break;
            case 4:
                canYouDoIt = @"nope.";
                break;
            case 5:
                canYouDoIt = @"nope.";
                break;
            default:
                canYouDoIt = @"nope.";
                break;
        }
    }else if(timeLeft > 10 && timeLeft <= 24){
        switch (judgementOfLength) {
            case 0:
                canYouDoIt = @"this should be a cakewalk, temporally speaking.";
                break;
            case 1:
                canYouDoIt = @"you can do this.";
                break;
            case 2:
                canYouDoIt = @"you can do this.";
                break;
            case 3:
                canYouDoIt = @"you're going to need to concentrate a bit to get this done.";
                break;
            case 4:
                canYouDoIt = @"Not too likely..";
                break;
            case 5:
                canYouDoIt = @"... yeah no. Nope.";
                break;
            default:
                canYouDoIt = @"nope.";
                break;
        }
    }else if(timeLeft > 24 && timeLeft <=36){
        switch (judgementOfLength) {
            case 0:
                canYouDoIt = @"you can do this easily if you concentrate.";
                break;
            case 1:
                canYouDoIt = @"you can do this easily if you concentrate.";
                break;
            case 2:
                canYouDoIt = @"you can do this easily if you concentrate.";
                break;
            case 3:
                canYouDoIt = @"you should grab some coffee and buckle down.";
                break;
            case 4:
                canYouDoIt = @"u r going 2 cri.";
                break;
            case 5:
                canYouDoIt = @"you're screwed.";
                break;
            default:
                canYouDoIt = @"nope.";
                break;
        }
    }else if(timeLeft > 36 && timeLeft <= 48){
        switch (judgementOfLength) {
            case 0:
                canYouDoIt = @"you should concentrate well. You'll be fine.";
                break;
            case 1:
                canYouDoIt = @"you should concentrate well. You'll be fine.";
                break;
            case 2:
                canYouDoIt = @"you should concentrate well. You'll be fine.";
                break;
            case 3:
                canYouDoIt = @"you REALLY need to concentrate hard. Pressure's on.";
                break;
            case 4:
                canYouDoIt = @"chances are looking über slim.";
                break;
            case 5:
                canYouDoIt = @"nope.";
                break;
            default:
                canYouDoIt = @"nope.";
                break;
        }
    }else if(timeLeft > 48 && timeLeft <= 72){
        switch (judgementOfLength) {
            case 0:
                canYouDoIt = @"you can do this.";
                break;
            case 1:
                canYouDoIt = @"you can do this.";
                break;
            case 2:
                canYouDoIt = @"you can do this.";
                break;
            case 3:
                canYouDoIt = @"it's not going to be easy, but you'll be able to do this.";
                break;
            case 4:
                canYouDoIt = @"you're in trouble.";
                break;
            case 5:
                canYouDoIt = @"there's still hope.";
                break;
            default:
                canYouDoIt = @"... you have time to plan for this.";
                break;
        }
    }else if(timeLeft > 72){
                
            canYouDoIt = @"unless you're bogged down with other work (or personal issues), there's no excuse to NOT be able to do this.";
    }
    
    NSLog(@"can you do this: %@", canYouDoIt);
    
    //average composition speed: 19wpm
    int timeWithoutDistraction = round(numberOfWords/19)*60;
    
    //Average productive time per 8 hours: 2 hours and 53 minutes, which gives multiplier 2.774.
    int actualTime = round(timeWithoutDistraction*2.774);

    //Hours of research per word count: 1 hour per 300 words.
    int timeWithResearchAndDistraction = actualTime + round((numberOfWords/300)*60)*60;
    
    //Average percent of wasted time on Facebook: 41%
    int timeWastedOnFacebook = round((actualTime-timeWithoutDistraction)*0.41);
    
    //average reading speed: 200wpm.
    int timeToRead = round(numberOfWords/200)*60;
    
    //average calories burned: 46 per half hour for 140 pound individuals == 92 calories per hour which, per second is
    // .025555 calories per second.
    int calories = round(timeWithoutDistraction*.025555);
    
    //number of hours coffee stays in system: 2-5 hours. We'll use 2.
    int coffee = round(actualTime/(60*60*2));
    
    //Hours of proofreading per word count
    int proofReadingTime = round(numberOfWords/666)*60*60;
    
    //10-15 page paper should have 5-8 sources. So we'll say 1 source for every 425 words. And 3 references per source.
    int sources = round(numberOfWords/425);
    int references = sources*3;
    
    results = [@{@"wordsPerPage": [NSNumber numberWithDouble:wordsPerPage],
                     @"numberOfWords": [NSNumber numberWithDouble:numberOfWords],
                     @"possible": canYouDoIt,
                     @"timeLeft": [NSNumber numberWithDouble:timeLeft],
                     @"timeNoDistract": [NSNumber numberWithInt:timeWithoutDistraction],
                     @"timeToComplete": [NSNumber numberWithInt:actualTime],
                     @"timeToResearchAndComplete": [NSNumber numberWithInt:timeWithResearchAndDistraction],
                     @"facebook": [NSNumber numberWithInt:timeWastedOnFacebook],
                     @"readtime": [NSNumber numberWithInt:timeToRead],
                     @"calories": [NSNumber numberWithInt:calories],
                     @"coffee": [NSNumber numberWithInt:coffee],
                     @"proofread": [NSNumber numberWithInt:proofReadingTime],
                     @"sources": [NSNumber numberWithInt:sources],
                     @"references": [NSNumber numberWithInt:references]} mutableCopy];
    NSLog(@"%@", results);
       return results;
}

@end
