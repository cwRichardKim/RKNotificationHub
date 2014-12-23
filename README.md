RKNotificationHub
=================

A way to quickly add a notification icon to a UIView

###DEMO

Take any button

![demo](http://i.imgur.com/LG2EEB6.gif)

Code:
``` objc
  RKNotificationHub* hub = [[RKNotificationHub alloc]initWithView:yourView];
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
  -(void)setCount:(int)newCount; //%%% set to a certain number
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
