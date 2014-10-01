RKNotificationHub
=================

A way to quickly add a notification icon to a UIButton

###Demo

__Take any button__

![button](http://i.imgur.com/MkFvakk.png?1)

__Add some code__

``` objc
  hub = [[RKNotificationHub alloc]init];
  [hub setButton:button andCount:1];
```

__Voilà!__

![hub](http://i.imgur.com/boGyL9T.gif)

###Usage
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
```

###Animations
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
http://i.imgur.com/boGyL9T.gif
![blink](http://i.imgur.com/boGyL9T.gif)
``` objc
  [hub increment];
  [hub pop];
```

###Customize
![blink](http://i.imgur.com/Ftbrh87.gif)
``` objc
  [hub setCircleColor:[UIColor colorWithRed:0.98 green:0.66 blue:0.2 alpha:1] 
           labelColor:[UIColor whiteColor]];
```

![frame](http://i.imgur.com/6w9WaO4.png?1)
```objc
  [hub setCircleAtFrame:CGRectMake(-10, -10, 30, 30)];
```
