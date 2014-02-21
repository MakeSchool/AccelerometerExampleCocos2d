//
//  MainScene.h
//  MGWU
//
//  Created by Benjamin Encz on 11/12/13.
//  Copyright MakeGamesWithUs 2013. Free to use for all purposes.
//
// -----------------------------------------------------------------------

#import "MainScene.h"
#import <CoreMotion/CoreMotion.h>


@implementation MainScene {
    // important: only create one instance of a motion manager
    CMMotionManager *_motionManager;
    CCLabelTTF *_label;
}

+ (MainScene *)scene
{
    return [[self alloc] init];
}

- (id)init
{
    if (self = [super init])
    {
        _label= [CCLabelTTF labelWithString:@"X" fontName:@"Arial" fontSize:48];
        
        [self addChild:_label];
        
        _motionManager = [[CMMotionManager alloc] init];
    }
	return self;
}

- (void)onEnter
{
    [super onEnter];
    
    _label.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    
    [_motionManager startAccelerometerUpdates];
}

- (void)onExit
{
    [super onExit];
    
    [_motionManager stopAccelerometerUpdates];
}

#pragma mark - Updates

- (void)update:(CCTime)delta {
    CMAccelerometerData *accelerometerData = _motionManager.accelerometerData;
    CMAcceleration acceleration = accelerometerData.acceleration;
    
    CGFloat newXPosition = _label.position.x + acceleration.y * 1000 * delta;
    newXPosition = clampf(newXPosition, 0, self.contentSize.width);
    _label.position = CGPointMake(newXPosition, _label.position.y);
}

@end