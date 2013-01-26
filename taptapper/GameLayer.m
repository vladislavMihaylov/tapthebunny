//
//  HelloWorldLayer.m
//  taptapper
//
//  Created by Vlad on 25.01.13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"
#import "GameConfig.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


// HelloWorldLayer implementation
@implementation GameLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) sceneWithAnimal: (NSInteger) numOfAnimal
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [[[GameLayer alloc] initWithAnimal: numOfAnimal] autorelease];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) dealloc
{
	[super dealloc];
}

-(id) initWithAnimal: (NSInteger) animal
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
		
		CCLOG(@"CurAnimal: %i", animal);
		
	
	}
	return self;
}



@end
