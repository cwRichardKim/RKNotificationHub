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
    RKNotificationHub *barHub;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButtonItem;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupButton];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"earth"]];
    imageView.frame = CGRectMake(self.view.frame.size.width/2 - 35, 120, 70, 70);
    
    hub = [[RKNotificationHub alloc]initWithView:imageView];
    [hub moveCircleByX:-5 Y:5]; // moves the circle five pixels left and 5 down
//    [hub hideCount]; // uncomment for a blank badge
  
    barHub = [[RKNotificationHub alloc] initWithBarButtonItem: _barButtonItem];
    [barHub increment];
  
    [self.view addSubview:imageView];
}


- (IBAction)barButtonPressed:(id)sender {
  [barHub increment];
  [barHub pop];
}

-(void)testIncrement
{
    [hub increment];

    [hub pop];
//    [hub blink];
//    [hub bump];
}

// (ignore this, for personal stress testing purposes)
- (void)stressTest {
    [hub setCount:pow(10, arc4random_uniform(5))];
    int rand = arc4random_uniform(7);
    switch (rand)
    {
        case 0:
            [hub scaleCircleSizeBy: 1.2];
            break;
        case 1:
            [hub scaleCircleSizeBy: .833];
            break;
        default:
            break;
    }
    rand = arc4random_uniform(4);
    switch (rand)
    {
        case 0:
            [hub pop];
            break;
        case 1:
            [hub blink];
            break;
        case 2:
            [hub bump];
            break;
        default:
            break;
    }
}

-(void)setupButton
{
    UIColor* color = [UIColor colorWithRed:.15 green:.67 blue:.88 alpha:1];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 400, 200, 60)];
    button.center = self.view.center;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"Increment" forState:UIControlStateNormal];
    [button setBackgroundColor:color];
    button.layer.cornerRadius = 5;
    [button addTarget:self action:@selector(testIncrement) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
