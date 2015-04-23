//
//  MainScene.m
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

- (void)didLoadFromCCB
{
    _label= [CCLabelTTF labelWithString:@"X" fontName:@"ArialMT" fontSize:48];
    
    [self addChild:_label];
        
    _motionManager = [[CMMotionManager alloc] init];

}

- (void)onEnter
{
    [super onEnter];
    
    _label.position = ccp([CCDirector sharedDirector].viewSize.width/2, [CCDirector sharedDirector].viewSize.height/2);
    
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
    newXPosition = clampf(newXPosition, 0, [CCDirector sharedDirector].viewSize.width);
    _label.position = CGPointMake(newXPosition, _label.position.y);
}

@end