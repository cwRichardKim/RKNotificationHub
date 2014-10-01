RKNotificationHub
=================

A way to quickly add a notification icon to a UIButton

###DEMO

Take any button

![demo](http://i.imgur.com/LG2EEB6.gif)

Code:
``` objc
  RKNotificationHub* hub = [[RKNotificationHub alloc]init];
  [hub setButton:button andCount:1]; //%%% the initial count
```

###USAGE
![increment](http://i.imgur.com/zpgkNtE.gif)
``` objc
  [hub increment];
```
__Other Options__
``` objc
  -(void)increment;
  -(void)incrementBy:(int)amount;
  -(void)decrement;
  -(void)decrementBy:(int)amount;
  -(void)setCount:(int)currentCount; //%%% set to a certain number
  
  //%%% using a set (see below)
  @property (nonatomic)NSMutableSet* objectsSet;
  -(void)updateWithSetCount;
  
  //%%% using an array
  @property (nonatomic)NSMutableArray* objectArray;
  -(void)updateWithArrayCount;
```

###ANIMATIONS
![pop](http://i.imgur.com/g6tMepj.gif)
``` objc
  [hub pop];
```

![bump](http://i.imgur.com/B2l0LDJ.gif)
``` objc
  [hub bump];
```

![blink](http://i.imgur.com/9XJ8dfP.gif)
``` objc
  [hub blink];
```

__Combine Actions!__

![blink](http://i.imgur.com/boGyL9T.gif)
``` objc
  [hub increment];
  [hub pop];
```

###CUSTOMIZE
![blink](http://i.imgur.com/Ftbrh87.gif)
``` objc
  //%%% COLOR
  [hub setCircleColor:[UIColor colorWithRed:0.98 green:0.66 blue:0.2 alpha:1] 
           labelColor:[UIColor whiteColor]];
```

![frame](http://i.imgur.com/6w9WaO4.png?1)
```objc
  //%%% CIRCLE FRAME
  [hub setCircleAtFrame:CGRectMake(-10, -10, 30, 30)];
```


###USING SETS OR ARRAYS
If you have your own array (say an array of notifications or an array of messages), you can use this section so that you don't have to manually change the count

```objc
  //%%% using a set
  @property (nonatomic)NSMutableSet* objectSet;
  -(void)updateWithSetCount;
  
  //%%% using an array
  @property (nonatomic)NSMutableArray* objectArray;
-(void)updateWithArrayCount;
```
Using a set
```objc
  hub.objectSet = yourSet;
  [hub updateWithSetCount];
  
  //%%% or
  [hub.objectSet addObject:@"a unique id of a message"];
  [hub updateWithSetCount];
  //%%% this will increment the count by one if that id doesn't already exist in the set
```
Using an array
```objc
  hub.objectArray = yourArray;
  [hub updateWithArrayCount];
  
  //%%% or
  [hub.objectArray addObject:@"a unique id of a message"];
  [hub updateWithArrayCount];
  //%%% this will increment the count by one regardless of whether that id exists already
```
Of course you can do the other standard set / array operations (removing objects, printing them, looping through them, etc)
