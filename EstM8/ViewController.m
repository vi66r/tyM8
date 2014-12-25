//
//  ViewController.m
//  EstM8
//
//  Created by Rafi Rizwan on 12/20/14.
//  Copyright (c) 2014 Rafi Rizwan. All rights reserved.
//

#import "ViewController.h"
#import "dateParser.h"
#import "paperDataParser.h"
#import "presentationCard.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@property(strong, nonatomic) UIView* topBanner;

@property(strong, nonatomic) NSNumber* numberOfPages;
@property(strong, nonatomic) NSNumber* daysRemaining;
@property(strong, nonatomic) NSNumber* dueTime;
@property(strong, nonatomic) NSDate* dueDate;
@property(strong, nonatomic) NSMutableDictionary* results;

@property(strong, nonatomic) NSArray* dayArray;
@property(strong, nonatomic) NSDate* currentDate;

@property(nonatomic) CGRect screen;

@property (strong, nonatomic) UIScrollView* main;
@property (strong, nonatomic) UILabel *first;
@property (strong, nonatomic) UITextField *paperNumber;
@property (strong, nonatomic) UILabel *two;
@property (strong, nonatomic) UITextField *date;
@property (strong, nonatomic) UILabel* three;
@property (strong, nonatomic) UITextField* time;

@property (strong, nonatomic) UIButton* go;
@property (strong, nonatomic) UIButton* close;

@property (strong, nonatomic) dateParser *dateParser;
@property (strong, nonatomic) paperDataParser *paperDateParser;

@property (strong, nonatomic) UISwipeGestureRecognizer *swipeRight;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeLeft;
@property (strong, nonatomic) UITapGestureRecognizer *keyboardTap;

@property (strong, nonatomic) UIView* cardOne;
@property (strong, nonatomic) UILabel* looksLike;
@property (strong, nonatomic) UILabel* possiblé;

@property (strong, nonatomic) NSMutableArray* cardArray;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    _dateParser = [[dateParser alloc] init];
    _paperDateParser = [[paperDataParser alloc] init];
    
    _swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveLeft)];
    _swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveRight)];
    _swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    _keyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    _cardArray = [[NSMutableArray alloc] init];;
    
    self.view.backgroundColor = UIColorFromRGB(0xE0F7FA);
    _screen = [[UIScreen mainScreen] bounds];
    _main = [[UIScrollView alloc] initWithFrame:_screen];
    _main.backgroundColor = UIColorFromRGB(0xE0F7FA);
    //_main.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_main];
    _main.contentSize = CGSizeMake(_screen.size.width, _screen.size.height+10);
    _first = [[UILabel alloc] initWithFrame:CGRectMake(0, _screen.size.height/2-180, _screen.size.width, 66)];
    _first.text = @"I have to write a";
    _first.textColor = [UIColor orangeColor];
    _first.textAlignment = NSTextAlignmentCenter;
    _first.font = [UIFont fontWithName:@"Avenir-Black" size:30];
    [_main addSubview:_first];
    _paperNumber = [[UITextField alloc] initWithFrame:CGRectMake(0, _screen.size.height/2-180+44,_screen.size.width, 66)];
    _paperNumber.placeholder = @"7";
    _paperNumber.font = [UIFont fontWithName:@"Avenir-Black" size:30];
    _paperNumber.textColor = [UIColor redColor];
    _paperNumber.backgroundColor = [UIColor clearColor];
    _paperNumber.textAlignment = NSTextAlignmentCenter;
    _paperNumber.delegate = self;
    [_main addSubview:_paperNumber];
    [self.view addGestureRecognizer:_keyboardTap];
    
    _two = [[UILabel alloc] initWithFrame:CGRectMake(0, _screen.size.height/2-180+44+33, _screen.size.width, 66)];
    _two.text = @"page paper by";
    _two.textColor = [UIColor orangeColor];
    _two.textAlignment = NSTextAlignmentCenter;
    _two.font = [UIFont fontWithName:@"Avenir-Black" size:30];
    [_main addSubview:_two];
    
    _date = [[UITextField alloc] initWithFrame:CGRectMake(0, _screen.size.height/2-180+44+33+50,_screen.size.width, 66)];
    _date.placeholder = @"next Monday";
    _date.font = [UIFont fontWithName:@"Avenir-Black" size:30];
    _date.textColor = [UIColor redColor];
    _date.backgroundColor = [UIColor clearColor];
    _date.textAlignment = NSTextAlignmentCenter;
    _date.delegate = self;
    [_main addSubview:_date];
    
    _three = [[UILabel alloc] initWithFrame:CGRectMake(0, _screen.size.height/2-180+44+33+55+35, _screen.size.width, 66)];
    _three.text = @"at";
    _three.textColor = [UIColor orangeColor];
    _three.textAlignment = NSTextAlignmentCenter;
    _three.font = [UIFont fontWithName:@"Avenir-Black" size:30];
    [_main addSubview:_three];
    
    _time = [[UITextField alloc] initWithFrame:CGRectMake(0, _screen.size.height/2-180+44+33+55+33+50,_screen.size.width, 66)];
    _time.placeholder = @"3 PM";
    _time.font = [UIFont fontWithName:@"Avenir-Black" size:30];
    _time.textColor = [UIColor redColor];
    _time.backgroundColor = [UIColor clearColor];
    _time.textAlignment = NSTextAlignmentCenter;
    _time.delegate = self;
    [_main addSubview:_time];
    
    _go = [UIButton buttonWithType:UIButtonTypeCustom];
    [_go setFrame:CGRectMake(_screen.size.width/2-33, _screen.size.height/2-180+44+33+55+33+50+80+50,66, 66)];
    [_go setTitle:@"+" forState:normal];
    [_go.titleLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:40]];
    [_go.titleLabel setTextColor:[UIColor redColor]];
    [_go setTintColor:[UIColor orangeColor]];
    _go.layer.cornerRadius = _go.frame.size.width/2;
    _go.layer.shadowColor = [[UIColor clearColor] colorWithAlphaComponent:0.5].CGColor;
    _go.layer.shadowOffset = CGSizeMake(0, 1);
    _go.layer.shadowOpacity = 1.0f;
    _go.layer.shadowRadius = 1.0f;
    _go.backgroundColor = [UIColor orangeColor];
    [_go addTarget:self action:@selector(calculate) forControlEvents:UIControlEventTouchUpInside];
    
    _close = [UIButton buttonWithType:UIButtonTypeCustom];
    [_close setFrame:CGRectMake(_screen.size.width-86-10+33, _screen.size.height-86-10+33,0, 0)];
    [_close setTitle:@"-" forState:normal];
    [_close.titleLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:40]];
    [_close.titleLabel setTextColor:[UIColor redColor]];
    [_close setTintColor:[UIColor orangeColor]];
    _close.layer.cornerRadius = _close.frame.size.width/2;
    _close.layer.shadowColor = [[UIColor clearColor] colorWithAlphaComponent:0.5].CGColor;
    _close.layer.shadowOffset = CGSizeMake(0, 1);
    _close.layer.shadowOpacity = 1.0f;
    _close.layer.shadowRadius = 1.0f;
    _close.backgroundColor = [UIColor redColor];
    [_close addTarget:self action:@selector(closeCard) forControlEvents:UIControlEventTouchUpInside];
    [_main addSubview:_close];
    
    
    UIView *upBanner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screen.size.width, 88)];
    NSLog(@"LOOKY LOOKY: /n/t %f", _screen.size.width);
    upBanner.backgroundColor = UIColorFromRGB(0x00BCD4);
    upBanner.layer.shadowColor = [[UIColor clearColor] colorWithAlphaComponent:0.5].CGColor;
    upBanner.layer.shadowOffset = CGSizeMake(0, 1);
    upBanner.layer.shadowOpacity = 1.0f;
    upBanner.layer.shadowRadius = 1.0f;
    _topBanner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screen.size.width, 22)];
    //[_topBanner setFrame:_screen];
    _topBanner.backgroundColor = UIColorFromRGB(0x006064);
    UIImageView *nn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NNbanner.png"]];
    nn.frame = CGRectMake(upBanner.frame.size.width/2-375/2, 22, 375, 66);
    [upBanner addSubview:nn];
    [upBanner addSubview:_topBanner];
    [self.view addSubview:upBanner];
    
    [_main addGestureRecognizer:_swipeLeft];
    [_main addGestureRecognizer:_swipeRight];
    
    _cardOne = [[UIView alloc] initWithFrame:CGRectMake(_screen.size.width/2-33, _screen.size.height/2-180+44+33+55+33+50+80+50,66, 66)];
    _cardOne.backgroundColor = [UIColor orangeColor];
    _cardOne.layer.cornerRadius = _cardOne.frame.size.width/2;
    _cardOne.layer.shadowColor = [[UIColor clearColor] colorWithAlphaComponent:0.5].CGColor;
    _cardOne.layer.shadowOffset = CGSizeMake(0, 1);
    _cardOne.layer.shadowOpacity = 1.0f;
    _cardOne.layer.shadowRadius = 1.0f;
    
    [_main addSubview:_cardOne];
    [_main addSubview:_go];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calculate {
    if ([_paperNumber.text isEqualToString:@""] || [_paperNumber.text isEqualToString:@""] || [_paperNumber.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh-oh" message:@"There's something wrong with what you've entred" delegate:nil cancelButtonTitle:@"okay" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        _dueDate = [_dateParser parseStringToDueDate:_date.text withTimeString:_time.text];
        if (_dueDate == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"..." message:@"Try a format that makes sense, yo." delegate:nil cancelButtonTitle:@"kayyy" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            _results = [_paperDateParser getPageStatsBasedWithNumberOfPages:[_paperNumber.text doubleValue] andDate:_dueDate];
            NSLog(@"central results: %@", _results);
            [_go removeFromSuperview];
            [_main bringSubviewToFront:_close];
            [UIView animateWithDuration:0.2 animations:^{
                [_cardOne setFrame:CGRectMake(15, 98, _screen.size.width-30, _screen.size.height - 118)];
                _cardOne.layer.cornerRadius = 0;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 animations:^{
                    [_cardOne setFrame:CGRectMake(20, 108, _screen.size.width-40, _screen.size.height - 128)];
                    [_close setFrame:CGRectMake(_screen.size.width-86-10, _screen.size.height-86-10, 66, 66)];
                    _close.layer.cornerRadius = _close.frame.size.width/2;
                    _cardOne.backgroundColor = [UIColor whiteColor];
                } completion:^(BOOL finished) {
                    //                [_main addSubview:_cardOne];
                    //                [_main bringSubviewToFront:_close];
                    
                    _looksLike = [[UILabel alloc] initWithFrame:CGRectMake(_cardOne.frame.size.width/2-100, _cardOne.frame.size.height/5+20, 200, 60)];
                    _looksLike.text = @"Looks like";
                    _looksLike.font = [UIFont fontWithName:@"Avenir-Black" size:40];
                    _looksLike.textColor = UIColorFromRGB(0x03A9F4);
                    _looksLike.alpha = 0;
                    [_cardOne addSubview:_looksLike];
                    _possiblé = [[UILabel alloc] initWithFrame:CGRectMake(_cardOne.frame.size.width/2-120, _cardOne.frame.size.height/5+90, 240, 240)];
                    _possiblé.text = [_results objectForKey:@"possible"];
                    _possiblé.font = [UIFont fontWithName:@"Avenir-Black" size:30];
                    _possiblé.textColor = UIColorFromRGB(0x03A9F4);
                    _possiblé.alpha = 0;
                    _possiblé.numberOfLines = 0;
                    [_possiblé sizeToFit];
                    _possiblé.textAlignment = NSTextAlignmentCenter;
                    [_cardOne addSubview:_possiblé];
                    _cardArray = [[NSMutableArray new] init];
                    for (int i = 0; i < 7; ++i) {
                        CGPoint position = CGPointMake(_screen.size.width + ((_screen.size.width * i)+20), _cardOne.frame.origin.y);
                        NSLog(@"x position: %f", _cardOne.frame.size.width/2 + ((_screen.size.width) * (i)));
                        NSLog(@"type Number: %i", i);
                        presentationCard* card = [[presentationCard new] initWithPosition:position andScreen:_screen andTypeNum:i andResults:_results];
                        [_cardArray addObject:card];
                        [_main addSubview:[_cardArray objectAtIndex:i]];
                        [_main bringSubviewToFront:_close];
                        [UIView animateWithDuration:0.4 animations:^{
                            _looksLike.alpha = 1.0;
                        } completion:^(BOOL finished) {
                            [UIView animateWithDuration:0.8 animations:^{
                                _possiblé.alpha = 1.0;
                            } completion:^(BOOL finished) {
                                //
                            }];
                        }];
                    }
                }];
            }];
            
            
            
            _go.userInteractionEnabled = NO;
        }
        NSLog(@"%@", _dueDate);

    }
}

- (void)moveLeft{
    CGRect comparator = CGRectMake(_screen.size.width/2-33, _screen.size.height/2-180+44+33+55+33+50+80+50,66, 66);
    if (!CGRectEqualToRect(_cardOne.frame, comparator)){
        [UIView animateWithDuration:0.25 animations:^{
            for (presentationCard *c in _cardArray) {
                [c setFrame:CGRectMake(c.frame.origin.x - _screen.size.width, _cardOne.frame.origin.y, _screen.size.width-40, _screen.size.height-128)];
            }
            [_cardOne setFrame:CGRectMake(_cardOne.frame.origin.x - _screen.size.width, _cardOne.frame.origin.y, _screen.size.width-40, _screen.size.height-128)];
        } completion:^(BOOL finished) {
            //
        }];
    }
}

- (void)moveRight{
    CGRect comparator = CGRectMake(_screen.size.width/2-33, _screen.size.height/2-180+44+33+55+33+50+80+50,66, 66);
    if (!CGRectEqualToRect(_cardOne.frame, comparator)){
        [UIView animateWithDuration:0.25 animations:^{
            for (presentationCard *c in _cardArray) {
                [c setFrame:CGRectMake(c.frame.origin.x + _screen.size.width, _cardOne.frame.origin.y, _screen.size.width-40, _screen.size.height-128)];
            }
            [_cardOne setFrame:CGRectMake(_cardOne.frame.origin.x + _screen.size.width, _cardOne.frame.origin.y, _screen.size.width-40, _screen.size.height-128)];
        } completion:^(BOOL finished) {
            //
        }];
    }
}

- (void)closeCard{
    _results = nil;
    CGRect comparator = CGRectMake(20, 108, _screen.size.width-40, _screen.size.height - 128);
    if (CGRectEqualToRect(_cardOne.frame, comparator)) {
        [UIView animateWithDuration:0.2 animations:^{
            [_close setFrame:CGRectMake(_screen.size.width-86-10+33, _screen.size.height-86-10+33, 0, 0)];
            [_cardOne setFrame:CGRectMake(15, 98, _screen.size.width-30, _screen.size.height - 118)];
            _looksLike.alpha = 0;
            _possiblé.alpha = 0;
            for (int i = 0; i < [_cardArray count]; ++i) {
                CGPoint position = CGPointMake(_screen.size.width + ((_screen.size.width * i)+20), _cardOne.frame.origin.y);
                [(presentationCard*)_cardArray[i] resetPosition:position onScreen:_screen];
            }
        } completion:^(BOOL finished) {
            //        [_cardOne removeFromSuperview];
            [_looksLike removeFromSuperview];
            [_possiblé removeFromSuperview];
            [UIView animateWithDuration:0.2 animations:^{
                [_cardOne setFrame:CGRectMake(_screen.size.width/2-33, _screen.size.height/2-180+44+33+55+33+50+80+50,66, 66)];
                _cardOne.layer.cornerRadius = 33;
                _cardOne.backgroundColor = [UIColor orangeColor];
            } completion:^(BOOL finished) {
                _go.userInteractionEnabled = YES;
                [_main addSubview:_go];
            }];
        }];
    } else {
        
        [UIView animateWithDuration:0.3 animations:^{
            [_close setFrame:CGRectMake(_screen.size.width-86-10+33, _screen.size.height-86-10+33, 0, 0)];
            [_cardOne setFrame:CGRectMake(15, 98, _screen.size.width-30, _screen.size.height - 118)];
            _looksLike.alpha = 0;
            _possiblé.alpha = 0;
            for (int i = 0; i < [_cardArray count]; ++i) {
                CGPoint position = CGPointMake(_screen.size.width + ((_screen.size.width * i)+20), _cardOne.frame.origin.y);
                [(presentationCard*)_cardArray[i] resetPosition:position onScreen:_screen];
            }
        } completion:^(BOOL finished) {
            //        [_cardOne removeFromSuperview];
            [_looksLike removeFromSuperview];
            [_possiblé removeFromSuperview];
            [UIView animateWithDuration:0.3 animations:^{
                [_cardOne setFrame:CGRectMake(_screen.size.width/2-33, _screen.size.height/2-180+44+33+55+33+50+80+50,66, 66)];
                _cardOne.layer.cornerRadius = 33;
                _cardOne.backgroundColor = [UIColor orangeColor];
            } completion:^(BOOL finished) {
                _go.userInteractionEnabled = YES;
                [_main addSubview:_go];
            }];
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

- (void)dismissKeyboard{
    [_paperNumber resignFirstResponder];
    [_date resignFirstResponder];
    [_time resignFirstResponder];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
