#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <FBSnapshotTestCase/FBSnapshotTestCase.h>
#import <Expecta+Snapshots/EXPMatchers+FBSnapshotTest.h>
#import <OCMock/OCMock.h>

#import "RKNotificationHub.h"

@implementation UIView(SpecFlywheel)

+ (void)animateWithDuration:(NSTimeInterval)duration
                 animations:(void (^)(void))animations
                 completion:(void (^)(BOOL finished))completion {
    if (animations)
        animations();
    if (completion)
        completion(YES);
}

@end

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

describe(@"changing the count", ^{
    __block UIView *view;
    __block RKNotificationHub *subject;
    
    before(^{
        view = [[UIView alloc] initWithFrame:CGRectZero];
        subject = [[RKNotificationHub alloc] initWithView:nil];
        [subject setView:view andCount:20];
    });
    
    describe(@"increment", ^{
        it(@"should increase count", ^{
            [subject increment];
            expect([subject count]).to.equal(21);
        });
    });
    
    describe(@"incrementBy:", ^{
        it(@"should increase count by given value", ^{
            [subject incrementBy:10];
            expect([subject count]).to.equal(30);
        });
    });
    
    describe(@"decrement", ^{
        it(@"should decrease count", ^{
            [subject decrement];
            expect([subject count]).to.equal(19);
        });
        
        it(@"should not decrease count if count is 0", ^{
            [subject setCount:0];
            [subject decrement];
            expect([subject count]).to.equal(0);
        });
    });
    
    describe(@"decrementBy:", ^{
        it(@"should decrease count by given value", ^{
            [subject decrementBy:15];
            expect([subject count]).to.equal(5);
        });
        
        it(@"should make count negative if given value is larger than the count", ^{
            [subject decrementBy:40];
            expect([subject count]).to.equal(-20);
        });
    });
    
    describe(@"setCount:", ^{
        it(@"should update count with given value", ^{
            [subject setCount:35];
            expect([subject count]).to.equal(35);
        });
    });
});

describe(@"animations", ^{
    __block UIView *view;
    __block RKNotificationHub *subject;
    
    before(^{
        view = [[UIView alloc] initWithFrame:CGRectZero];
        subject = [[RKNotificationHub alloc] initWithView:nil];
        [subject setView:view andCount:20];
    });
    
    describe(@"pop", ^{
        it(@"should not change count", ^{
            [subject pop];
            expect([subject count]).to.equal(20);
        });
    });
    
    describe(@"blink", ^{
        it(@"should not change count", ^{
            [subject blink];
            expect([subject count]).to.equal(20);
        });
    });
    
    describe(@"bump", ^{
        it(@"should not change count", ^{
            [subject bump];
            expect([subject count]).to.equal(20);
        });
    });
});

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

    describe(@"appearance", ^{
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
    
    describe(@"changing the count", ^{
        it(@"should look right when count is incremented", ^{
            [subject increment];
            expect(backgroundView).to.haveValidSnapshot();
        });
        
        it(@"should look right when count is incremented by value", ^{
            [subject incrementBy:3];
            expect(backgroundView).to.haveValidSnapshot();
        });
        
        it(@"should look right when count is decremented", ^{
            [subject decrement];
            expect(backgroundView).to.haveValidSnapshot();
        });
        
        it(@"should look right when count is decremented by value", ^{
            [subject decrementBy:3];
            expect(backgroundView).to.haveValidSnapshot();
        });
    });
    
    describe(@"hideCount", ^{
        it(@"should look right with hidden count", ^{
            [subject showCount];
            [subject hideCount];
            expect(backgroundView).to.haveValidSnapshot();
        });
    });
    
    describe(@"showCount", ^{
        it(@"should look right with visible count", ^{
            [subject hideCount];
            [subject showCount];
            expect(backgroundView).to.haveValidSnapshotNamed(@"default_5");
        });
    });
    
    describe(@"animations", ^{
        describe(@"pop", ^{
            it(@"should look right when animation is completed", ^{
                [subject pop];
                expect(backgroundView).to.haveValidSnapshotNamed(@"default_5");
            });
        });
        
        describe(@"blink", ^{
            it(@"should look right when animation is completed", ^{
                [subject blink];
                expect(backgroundView).to.haveValidSnapshotNamed(@"default_5");
            });
        });
        
        describe(@"bump", ^{
            it(@"should look right when animation is completed", ^{
                [subject bump];
                expect(backgroundView).to.haveValidSnapshotNamed(@"default_5");
            });
        });
    });
});

SpecEnd