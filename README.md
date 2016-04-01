RKNotificationHub
=================

A way to quickly add a notification icon to a UIView (iOS6 and up). [Support](http://cwrichardkim.com)

![demo](http://i.imgur.com/SpE2BQv.gif)

Code:
``` objc
  RKNotificationHub* hub = [[RKNotificationHub alloc]initWithView:yourView]; // sets the count to 0
  [hub increment]; // increments the count to 1, making the notification visible
```

###Pod
```
    pod 'RKNotificationHub'
```

###USAGE
![increment](http://i.imgur.com/zpgkNtE.gif)
``` objc
  [hub increment];
```
``` objc
  -(void)increment;
  -(void)incrementBy:(int)amount;
  -(void)decrement;
  -(void)decrementBy:(int)amount;
  @property (nonatomic, assign) int count; //%%% set to a certain number
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
  [hub setCircleAtFrame:CGRectMake(-10, -10, 30, 30)]; //frame relative to the view you set it to

  //%%% MOVE FRAME
  [hub moveCircleByX:-5 Y:5]; // moves the circle 5 pixels left and down from its current position

  //%%% CIRCLE SIZE
  [hub scaleCircleSizeBy:2]; // doubles the size of the circle, keeps the same center
```

![blank](http://i.imgur.com/rhiKOPH.png)
``` objc
  //%%% BLANK BADGE
  [hub hideCount];
  /* shoutout to imkevinxu for this suggestion */
```


###TROUBLESHOOTING
**Notification isn't showing up!**
* If the hub value is < 1, the circle hides.  Try calling [increment]
* Make sure the view you set the hub to is visible (i.e. did you call [self.view addSubview: yourView]?)
* Make sure you didn't call [hideCount] anywhere. Call [showCount] to counter this

**It isn't incrementing / decrementing properly!**
* I've written it so that any count < 1 doesn't show up. If you need help customizing this, reach out to me

**The circle is in a weird place**
* If you want to resize the circle, use [scaleCircleSizeBy:]. 0.5 will give you half the size, 2 will give you double
* If the circle is just a few pixels off, use [moveCircleByX: Y:]. This shifts the circle by the number of pixels given
* If you want to manually set the circle, call [setCircleAtFrame:] and give it your own CGRect

**Something else isn't working properly**
* Send me a tweet @cwRichardKim with #RKNotificationHub so that other people can search these issues too
* Use github's issue reporter on the right
* Send me an email cwRichardKim@gmail.com (might take a few days)


### Updates
* 1.0.0 first release with cocoapod
* 1.0.1 cocoapod allows iOS 7.0
* 1.0.2 added "hideCount", "showCount", and "count" methods, allowing indeterminate badges with no number
* 1.0.5 added bubble expansion for larger numbers [(gif)](http://i.imgur.com/cpQuShT.gif)
* 2.0.0 changed count to `NSUInteger` (removed support for negative counts), made local constants `static const`
* 2.0.1 iOS 6 compatability
* 2.0.2 changed count back to 'int' for better swift compatability
* 2.0.4 fixed cocoapod update issue

### Areas for Improvements / involvement
* A mechanism for adding a custom animation
* Singleton option
