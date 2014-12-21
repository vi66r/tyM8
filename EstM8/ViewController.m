//
//  ViewController.m
//  EstM8
//
//  Created by Rafi Rizwan on 12/20/14.
//  Copyright (c) 2014 Rafi Rizwan. All rights reserved.
//

#import "ViewController.h"
#import "dateParser.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()

@property(strong, nonatomic) NSNumber* numberOfPages;
@property(strong, nonatomic) NSNumber* daysRemaining;
@property(strong, nonatomic) NSNumber* dueTime;
@property(strong,nonatomic) NSDate* dueDate;

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

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    
    _dateParser = [[dateParser alloc] init];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _screen = [[UIScreen mainScreen] bounds];
    _main = [[UIScrollView alloc] initWithFrame:_screen];
    _main.backgroundColor = UIColorFromRGB(0x276469);
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
    [_go setFrame:CGRectMake(0, _screen.size.height/2-180+44+33+55+33+50+80,_screen.size.width, 66)];
    [_go setTitle:@"TELL ME HOW LONG!" forState:normal];
    [_go.titleLabel setFont:[UIFont fontWithName:@"Avenir-Black" size:30]];
    [_go.titleLabel setTextColor:[UIColor redColor]];
    [_go setTintColor:[UIColor redColor]];
    _go.backgroundColor = [UIColor redColor];
    [_main addSubview:_go];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calculate {
    _dueDate = [_dateParser parseStringToDueDate:_date.text];
}

@end
