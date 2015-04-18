#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <Expecta+Snapshots/EXPMatchers+FBSnapshotTest.h>
#import <OCMock/OCMock.h>

#import "RKNotificationHub.h"

SpecBegin(RKNotificationHub)

// setup

describe(@"initWithView:", ^{
    __block UIView *view;
    __block RKNotificationHub *subject;
    
    beforeAll(^{
        view = [[UIView alloc] initWithFrame:CGRectZero];
        subject = [[RKNotificationHub alloc] initWithView:view];
    });
    
    it(@"should initialize hub with given view as hubView", ^{
        expect(subject.hubView).to.equal(view);
    });
    
    it(@"should initialize hub with count 0", ^{
        expect([subject count]).to.equal(0);
    });
});

describe(@"setView:andCount:", ^{
    __block UIView *view;
    __block RKNotificationHub *subject;
    
    beforeAll(^{
        view = [[UIView alloc] initWithFrame:CGRectZero];
        subject = [[RKNotificationHub alloc] initWithView:nil];
        [subject setView:view andCount:2];
    });
    
    it(@"should set hub view", ^{
        expect(subject.hubView).to.equal(view);
    });
    
    it(@"should set count", ^{
        expect([subject count]).to.equal(2);
    });
});

// changing the count

describe(@"increment", ^{
    
});

describe(@"incrementBy:", ^{
    
});

describe(@"decrement", ^{
    
});

describe(@"decrementBy:", ^{
    
});

describe(@"setCount:", ^{
    
});

describe(@"count", ^{
    
});

// hiding / showing the count

describe(@"hideCount", ^{
    
});

describe(@"showCount", ^{
    
});

// animations

describe(@"pop", ^{
    
});

describe(@"blink", ^{
    
});

describe(@"bump", ^{
    
});

// snapshots

describe(@"visuals", ^{
    __block UIView *backgroundView;
    __block UIView *targetView;
    __block RKNotificationHub *subject;
    
    before(^{
        backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 200.0, 200.0)];
        
        targetView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 100.0, 40.0)];
        targetView.center = backgroundView.center;
        [targetView setBackgroundColor:[UIColor lightGrayColor]];
        
        [backgroundView addSubview:targetView];
        
        subject = [[RKNotificationHub alloc] initWithView:targetView];
        [subject setCount:5];
    });

    it(@"should not display notification icon when count is 0", ^{
        [subject setCount:0];
        expect(backgroundView).to.haveValidSnapshot();
    });
    
    it(@"should display notification icon when count is not zero", ^{
        expect(backgroundView).to.haveValidSnapshotNamed(@"default_5");
    });
    
    it(@"should have red background and white label by default", ^{
        expect(backgroundView).to.haveValidSnapshotNamed(@"default_5");
    });
    
    it(@"should display the icon centered in the top right corner of the target view by default", ^{
        expect(backgroundView).to.haveValidSnapshotNamed(@"default_5");
    });
    
    it(@"should adjust icon width for larger count", ^{
        [subject setCount:375];
        expect(backgroundView).to.haveValidSnapshot();
    });
    
    describe(@"adjustment methods", ^{
        it(@"should look right with updated notification icon frame", ^{
            [subject setCircleAtFrame:CGRectMake(25.0, 30.0, 20.0, 15.0)];
            expect(backgroundView).to.haveValidSnapshot();
        });
        
        it(@"should look right with updated circle color and label color ", ^{
            [subject setCircleColor:[UIColor yellowColor] labelColor:[UIColor blackColor]];
            expect(backgroundView).to.haveValidSnapshot();
        });
        
        it(@"should look right with moved notification icon", ^{
            [subject moveCircleByX:-20.0 Y:30.0];
            expect(backgroundView).to.haveValidSnapshot();
        });
        
        it(@"should look right with scaled notification icon", ^{
            [subject scaleCircleSizeBy:1.5];
            expect(backgroundView).to.haveValidSnapshot();
        });
    });
});

SpecEnd