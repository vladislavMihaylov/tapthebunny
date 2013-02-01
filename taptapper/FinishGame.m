//
//  FinishGame.m
//  taptapper
//
//  Created by Vlad on 30.01.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "FinishGame.h"
#import "CCBReader.h"

#import "GameConfig.h"

#import "SimpleAudioEngine.h"

@implementation FinishGame

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    FinishGame *layer = [[[FinishGame alloc] init] autorelease];
    
    [scene addChild: layer];
    
    return scene;
}

- (void) dealloc
{
    [super dealloc];
}

- (id) init
{
    if(self = [super init])
    {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic: @"FamilyWin.mp3" loop: YES];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString: @"You Win!!" fontName: @"Arial" fontSize: 48];
        label.position = ccp(240, 160);
        [self addChild: label];
        
        CCMenuItemFont *mainMenu = [CCMenuItemFont itemWithString: @"Main menu" target: self selector: @selector(gotoMainMenu)];
        
        mainMenu.position = ccp(240, 120);
        
        CCMenu *menu = [CCMenu menuWithItems: mainMenu, nil];
        menu.position = ccp(0, 0);
        [self addChild: menu];
    }
    
    return self;
}

- (void) gotoMainMenu
{
    CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"MainMenuScene%@.ccbi", postFix]];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
}

@end
