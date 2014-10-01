//
//  ViewController.m
//  RKNotificationHub
//
//  Created by Richard Kim on 9/30/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import "ViewController.h"
#import "RKNotificationHub.h"

@interface ViewController () {
    RKNotificationHub *hub;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor* color = [UIColor colorWithRed:.15 green:.67 blue:.88 alpha:1];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 200, 60)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"Messages" forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    button.layer.cornerRadius = 5;
    
    
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    hub = [[RKNotificationHub alloc]init];
    [hub setButton:button andCount:0];
    
    [hub setCircleAtFrame:CGRectMake(-10, -10, 30, 30)];
//    [hub setCircleColor:[UIColor colorWithRed:0.98 green:0.66 blue:0.2 alpha:1] labelColor:[UIColor whiteColor]];
    
    UIButton *testButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 30, 30)];
    testButton.backgroundColor = [UIColor blackColor];
    [self.view addSubview:testButton];
    [testButton addTarget:self action:@selector(test2) forControlEvents:UIControlEventTouchUpInside];
    
    [hub.objectSet addObject:@"a specific id of a message"];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)test
{
    [hub increment];
}

-(void)test2
{
    [hub increment];
    [hub bump];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
