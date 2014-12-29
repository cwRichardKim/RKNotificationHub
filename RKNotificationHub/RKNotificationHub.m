//
//  RKNotificationHub.m
//  RKNotificationHub
//
//  Created by Richard Kim on 9/30/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import "RKNotificationHub.h"
#import <QuartzCore/QuartzCore.h>

//%%% default diameter
static const float DIAMETER = 30;
//%%% pop values
static const float POP_START_RATIO = .85;
static const float POP_OUT_RATIO = 1.05;
static const float POP_IN_RATIO = .95;

//%%% blink values
static const float BLINK_DURATION = 0.1;
static const float BLINK_ALPHA = 0.1;

//%%% bump values
static const float FIRST_BUMP_DIST = 8;
static const float BUMP_TIME = 0.13;
static const float SECOND_BUMP_DIST = 4;
static const float BUMP_TIME_2 = 0.1;


@implementation RKNotificationHub {
    int count;
    UILabel* countLabel;
    UIView *redCircle;
    CGPoint initialCenter;
    CGRect initialFrame;
    BOOL isIntermediatMode;
}
@synthesize hubView;

#pragma mark - SETUP

-(id)initWithView:(UIView *)view
{
    self = [super init];
    if (!self) return nil;
    
    [self setView:view andCount:0];
    
    return self;
}

//%%% give this a view and an initial count (0 hides the notification circle)
// and it will make a hub for you
-(void)setView:(UIView *)view andCount:(int)startCount
{
    CGRect frame = view.frame;
    
    isIntermediatMode = NO;
    
    redCircle = [[UIView alloc]init];
    redCircle.userInteractionEnabled = NO;
    redCircle.backgroundColor = [UIColor redColor];
    
    countLabel = [[UILabel alloc]initWithFrame:redCircle.frame];
    countLabel.userInteractionEnabled = NO;
    [self setCount:startCount];
    [countLabel setTextAlignment:NSTextAlignmentCenter];
    countLabel.textColor = [UIColor whiteColor];
    
    [self setCircleAtFrame:CGRectMake(frame.size.width-(DIAMETER*2/3), -DIAMETER/3, DIAMETER, DIAMETER)];
    
    [view addSubview:redCircle];
    [view addSubview:countLabel];
    [view bringSubviewToFront:redCircle];
    [view bringSubviewToFront:countLabel];
    hubView = view;
    [self checkZero];
}

//%%% set the frame of the notification circle relative to the button
-(void)setCircleAtFrame:(CGRect)frame
{
    [redCircle setFrame:frame];
    initialCenter = CGPointMake(frame.origin.x+frame.size.width/2, frame.origin.y+frame.size.height/2);
    initialFrame = frame;
    countLabel.frame = redCircle.frame;
    redCircle.layer.cornerRadius = frame.size.width/2;
    [countLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:frame.size.width/2]];
}

//%%% moves the circle by x amount on the x axis and y amount on the y axis
-(void)moveCircleByX:(CGFloat)x Y:(CGFloat)y
{
    CGRect frame = redCircle.frame;
    frame.origin.x += x;
    frame.origin.y += y;
    [self setCircleAtFrame:frame];
}

//%%% changes the size of the circle. setting a scale of 1 has no effect
-(void)scaleCircleSizeBy:(CGFloat)scale
{
    CGRect fr = redCircle.frame;
    CGFloat diam = fr.size.width * scale;
    CGFloat diff = (fr.size.width - diam)/2;
    
    CGRect frame = CGRectMake(fr.origin.x + diff, fr.origin.y + diff, diam, diam);
    [self setCircleAtFrame:frame];
}

//%%% change the color of the notification circle
-(void)setCircleColor:(UIColor*)circleColor labelColor:(UIColor*)labelColor
{
    redCircle.backgroundColor = circleColor;
    [countLabel setTextColor:labelColor];
}

-(void)hideCount
{
    countLabel.hidden = YES;
    isIntermediatMode = YES;
}

-(void)showCount
{
    countLabel.hidden = NO;
    isIntermediatMode = NO;
}

#pragma mark - ATTRIBUTES

//%%% increases count by 1
-(void)increment
{
    [self setCount:count+1];
}

//%%% increases count by amount
-(void)incrementBy:(int)amount
{
    [self setCount:count+amount];
}

//%%% decreases count
-(void)decrement
{
    if (count == 0) {
        return;
    }
    [self setCount:count-1];
}

//%%% decreases count by amount
-(void)decrementBy:(int)amount
{
    [self setCount:count-amount];
}

//%%% set the count yourself
-(void)setCount:(int)newCount
{
    count = newCount;
    countLabel.text = [NSString stringWithFormat:@"%i",count];
    [self checkZero];
}

-(int)count
{
    return count;
}

#pragma mark - ANIMATION

//%%% animation that resembles facebook's pop
-(void)pop
{
    const float diameter = initialFrame.size.width;
    const float pop_start = diameter*POP_START_RATIO;
    const float time_start = 0.05;
    const float pop_out = diameter*POP_OUT_RATIO;
    const float time_out = .2;
    const float pop_in = diameter*POP_IN_RATIO;
    const float time_in = .05;
    const float pop_end = diameter;
    const float time_end = 0.05;
    
    CABasicAnimation *startSize = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    startSize.duration = time_start;
    startSize.beginTime = 0;
    startSize.fromValue = [NSNumber numberWithFloat:pop_end/2];
    startSize.toValue = [NSNumber numberWithFloat:pop_start/2];
    startSize.removedOnCompletion = FALSE;
    
    CABasicAnimation *outSize = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    outSize.duration = time_out;
    outSize.beginTime = time_start;
    outSize.fromValue = startSize.toValue;
    outSize.toValue = [NSNumber numberWithFloat:pop_out/2];
    outSize.removedOnCompletion = FALSE;
    
    CABasicAnimation *inSize = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    inSize.duration = time_in;
    inSize.beginTime = time_start+time_out;
    inSize.fromValue = outSize.toValue;
    inSize.toValue = [NSNumber numberWithFloat:pop_in/2];
    inSize.removedOnCompletion = FALSE;
    
    CABasicAnimation *endSize = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    endSize.duration = time_end;
    endSize.beginTime = time_in+time_out+time_start;
    endSize.fromValue = inSize.toValue;
    endSize.toValue=[NSNumber numberWithFloat:pop_end/2];
    endSize.removedOnCompletion = FALSE;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setDuration: time_start+time_out+time_in+time_end];
    [group setAnimations:[NSArray arrayWithObjects:startSize, outSize, inSize, endSize, nil]];
    
    [redCircle.layer addAnimation:group forKey:nil];
    
    [UIView animateWithDuration:time_start animations:^{
        CGRect frame = redCircle.frame;
        CGPoint center = redCircle.center;
        frame.size.height = pop_start;
        frame.size.width = pop_start;
        redCircle.frame = frame;
        redCircle.center = center;
    }completion:^(BOOL complete){
        [UIView animateWithDuration:time_out animations:^{
            CGRect frame = redCircle.frame;
            CGPoint center = redCircle.center;
            frame.size.height = pop_out;
            frame.size.width = pop_out;
            redCircle.frame = frame;
            redCircle.center = center;
        }completion:^(BOOL complete){
            [UIView animateWithDuration:time_in animations:^{
                CGRect frame = redCircle.frame;
                CGPoint center = redCircle.center;
                frame.size.height = pop_in;
                frame.size.width = pop_in;
                redCircle.frame = frame;
                redCircle.center = center;
            }completion:^(BOOL complete){
                [UIView animateWithDuration:time_end animations:^{
                    CGRect frame = redCircle.frame;
                    CGPoint center = redCircle.center;
                    frame.size.height = pop_end;
                    frame.size.width = pop_end;
                    redCircle.frame = frame;
                    redCircle.center = center;
                }];
            }];
        }];
    }];
}

//%%% animation that flashes on an off
-(void)blink
{
    [self setAlpha:BLINK_ALPHA];
    
    [UIView animateWithDuration:BLINK_DURATION animations:^{
        [self setAlpha:1];
    }completion:^(BOOL complete){
        [UIView animateWithDuration:BLINK_DURATION animations:^{
            [self setAlpha:BLINK_ALPHA];
        }completion:^(BOOL complete){
            [UIView animateWithDuration:BLINK_DURATION animations:^{
                [self setAlpha:1];
            }];
        }];
    }];
}

//%%% animation that jumps similar to OSX dock icons
-(void)bump
{
    if (!CGPointEqualToPoint(initialCenter,redCircle.center)) {
        //%%% canel previous animation
    }
    
    [self bumpCenterY:0];
    [UIView animateWithDuration:BUMP_TIME animations:^{
        [self bumpCenterY:FIRST_BUMP_DIST];
    }completion:^(BOOL complete){
        [UIView animateWithDuration:BUMP_TIME animations:^{
            [self bumpCenterY:0];
        }completion:^(BOOL complete){
            [UIView animateWithDuration:BUMP_TIME_2 animations:^{
                [self bumpCenterY:SECOND_BUMP_DIST];
            }completion:^(BOOL complete){
                [UIView animateWithDuration:BUMP_TIME_2 animations:^{
                    [self bumpCenterY:0];
                }];
            }];
        }];
    }];
}

#pragma mark - HELPERS

//%%% changes the Y origin of the notification circle
-(void)bumpCenterY:(float)yVal
{
    CGPoint center = redCircle.center;
    center.y = initialCenter.y-yVal;
    redCircle.center = center;
    countLabel.center = center;
}

-(void)setAlpha:(float)alpha
{
    redCircle.alpha = alpha;
    countLabel.alpha = alpha;
}

//%%% used for pop animation to change the diameter
-(CGRect)nextRectWithDiameter:(float)diameter
{
    const float initialD = initialFrame.size.width;
    float buffer = (initialD - diameter)/2;
    
    CGRect frame = redCircle.frame;
    frame.size.height = diameter;
    frame.size.width = diameter;
    frame.origin.x = redCircle.frame.origin.x + buffer;
    frame.origin.y = redCircle.frame.origin.y + buffer;
    return frame;
}

//%%% hides the notification if the value is 0
-(void)checkZero
{
    if (count <= 0) {
        redCircle.hidden = YES;
        countLabel.hidden = YES;
    } else {
        redCircle.hidden = NO;
        if (!isIntermediatMode) {
            countLabel.hidden = NO;
        }
    }
}

@end
