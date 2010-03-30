//
//  Ball.m
//  BrainShot
//
//  Created by  cogent on 10-3-29.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Ball.h"
#import "cocos2d.h"


@implementation Ball

@synthesize number;

+ (Ball *)withLabel:(int)number AtLeftIndex:(int)leftIndex AndRightIndex:(int)rightIndex
{
  int left = leftIndex * ballSize + ballSize/2;
  int right = rightIndex * ballSize + ballSize/2; 
  
  Ball *ball = [Ball spriteWithFile:@"circle_green.png"];
  ball.position =  ccp( left , right );
  
  // create and initialize a Label
  CCLabel* label = [CCLabel labelWithString:[NSString stringWithFormat:@"%d", number] fontName:@"Marker Felt" fontSize:32];
  // position the label on the center of the screen
  label.position = ccp(ballSize/2, ballSize/2);
  
  [ball setNumber:number];
  [ball addChild:label];
  
  return ball;
}

- (CGRect)rect
{
	CGSize s = [self.texture contentSize];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void)onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	if ( ![self containsTouchLocation:touch] ) return NO;
  
  id flip = [CCFlipX3D actionWithDuration:0.5];
  [self runAction:flip];
  NSLog([NSString stringWithFormat:@"touch:%d", [self number]]);
	return YES;
}

@end