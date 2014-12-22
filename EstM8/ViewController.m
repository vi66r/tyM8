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

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@property(strong, nonatomic) UIView* topBanner;

@property(strong, nonatomic) NSNumber* numberOfPages;
@property(strong, nonatomic) NSNumber* daysRemaining;
@property(strong, nonatomic) NSNumber* dueTime;
@property(strong, nonatomic) NSDate* dueDate;

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

@property (strong, nonatomic) dateParser *dateParser;
@property (strong, nonatomic) paperDataParser *paperDateParser;

@property (strong, nonatomic) UISwipeGestureRecognizer *swipeRight;
@property (strong, nonatomic) UISwipeGestureRecognizer *swipeLeft;

@property (strong, nonatomic) UIView* cardOne;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    
    _dateParser = [[dateParser alloc] init];
    _paperDateParser = [[paperDataParser alloc] init];
    
    _swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveLeft)];
    _swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    _swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(moveRight)];
    _swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addGestureRecognizer:_swipeLeft];
    [self.view addGestureRecognizer:_swipeRight];
    
    _cardOne = [[UIView alloc] initWithFrame:CGRectMake(20, 108, _screen.size.width-40, _screen.size.height - 128)];
    
    self.view.backgroundColor = UIColorFromRGB(0xE0F7FA);
    _screen = [[UIScreen mainScreen] bounds];
    _main = [[UIScrollView alloc] initWithFrame:_screen];
    _main.backgroundColor = UIColorFromRGB(0xE0F7FA);
    //_main.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_main];
    //_main.contentSize = CGSizeMake(_screen.size.width, _screen.size.height+10);
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
    [_main addSubview:_paperNumber];
    
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
    [_main addSubview:_time];
    
    _go = [UIButton buttonWithType:UIButtonTypeCustom];
    [_go setFrame:CGRectMake(_screen.size.width/2-33, _screen.size.height/2-180+44+33+55+33+50+80+50,66, 66)];
    [_go setTitle:@"+" forState:normal];
    [_go.titleLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:40]];
    [_go.titleLabel setTextColor:[UIColor redColor]];
    [_go setTintColor:[UIColor orangeColor]];
    _go.layer.cornerRadius = 33;
    _go.layer.shadowColor = [[UIColor clearColor] colorWithAlphaComponent:0.5].CGColor;
    _go.layer.shadowOffset = CGSizeMake(0, 1);
    _go.layer.shadowOpacity = 1.0f;
    _go.layer.shadowRadius = 1.0f;
    _go.backgroundColor = [UIColor orangeColor];
    [_go addTarget:self action:@selector(calculate) forControlEvents:UIControlEventTouchUpInside];
    [_main addSubview:_go];
    
    UIView *upBanner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screen.size.width, 88)];
    upBanner.backgroundColor = UIColorFromRGB(0x00BCD4);
    upBanner.layer.shadowColor = [[UIColor clearColor] colorWithAlphaComponent:0.5].CGColor;
    upBanner.layer.shadowOffset = CGSizeMake(0, 1);
    upBanner.layer.shadowOpacity = 1.0f;
    upBanner.layer.shadowRadius = 1.0f;
    _topBanner = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _screen.size.width, 22)];
    //[_topBanner setFrame:_screen];
    _topBanner.backgroundColor = UIColorFromRGB(0x006064);
    [upBanner addSubview:_topBanner];
    [self.view addSubview:upBanner];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calculate {
    _dueDate = [_dateParser parseStringToDueDate:_date.text withTimeString:_time.text];
    if (_dueDate == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"..." message:@"Try a format that makes sense, yo." delegate:nil cancelButtonTitle:@"kayyy" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [_paperDateParser getPageStatsBasedWithNumberOfPages:[_paperNumber.text doubleValue] andDate:_dueDate];
        [UIView animateWithDuration:0.2 animations:^{
            [_go setFrame:CGRectMake(15, 98, _screen.size.width-30, _screen.size.height - 118)];
            _go.layer.cornerRadius = 0;
            _go.backgroundColor = [UIColor whiteColor];
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.2 animations:^{
                [_go setFrame:CGRectMake(20, 108, _screen.size.width-40, _screen.size.height - 128)];
            } completion:^(BOOL finished) {
                [self.view addSubview:_cardOne];
            }];
        }];
        _go.userInteractionEnabled = NO;
    }
    NSLog(@"%@", _dueDate);
}

- (void)moveLeft{
    
}

- (void)moveRight{
    
}

@end
