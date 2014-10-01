//
//  RKNotificationHub.h
//  RKNotificationHub
//
//  Created by Richard Kim on 9/30/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RKNotificationHub : NSObject

//%%% setup attributes
-(void)setButton:(UIButton*)button andCount:(int)startCount;
-(void)setCircleAtFrame:(CGRect)frame;
-(void)setCircleColor:(UIColor*)circleColor labelColor:(UIColor*)labelColor;

//%%% changing the count
-(void)increment;
-(void)incrementBy:(int)amount;
-(void)decrement;
-(void)decrementBy:(int)amount;
-(void)setCount:(int)currentCount;

//%%% animations
-(void)pop;
-(void)blink;
-(void)bump;

//%%% using a set
-(void)updateWithSetCount;

@property (nonatomic)NSMutableSet* objectsSet;

@end
