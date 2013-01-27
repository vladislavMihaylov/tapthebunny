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

@synthesize guiLayer;

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) sceneWithAnimal: (NSInteger) numOfAnimal
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [[[GameLayer alloc] initWithAnimal: numOfAnimal] autorelease];
	
    GuiLayer *gui = [[[GuiLayer alloc] init] autorelease];
    
	// add layer as a child to scene
	[scene addChild: layer];
    [scene addChild: gui];
    
    layer.guiLayer = gui;
    gui.gameLayer = layer;
	
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
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            screenWidth = 480;
            screenHeight = 320;
        }
        else
        {
            screenWidth = 1024;
            screenHeight = 768;
        }
        
		CCSprite *boxSprite = [CCSprite spriteWithFile: @"Default.png"];
        
        boxSprite.position = ccp(screenWidth / 2, screenHeight / 2);
        
        boxSprite.rotation = -90;
        [self addChild: boxSprite];
        
		CCLOG(@"CurAnimal: %i", animal);
		
	
	}
	return self;
}



@end
