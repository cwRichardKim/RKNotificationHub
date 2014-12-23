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
    [self setupButton];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"earth"]];
    imageView.frame = CGRectMake(50, 50, 70, 70);
    
    hub = [[RKNotificationHub alloc]initWithView:imageView];
    [hub moveCircleByX:-5 Y:5];
    [self.view addSubview:imageView];
}

-(UIButton *)setupButton
{
    UIColor* color = [UIColor colorWithRed:.15 green:.67 blue:.88 alpha:1];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 400, 200, 60)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"Messages" forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    button.layer.cornerRadius = 5;
    [button addTarget:self action:@selector(testIncrement) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
    return button;
}

-(void)testIncrement
{
    [hub increment];
    [hub pop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
