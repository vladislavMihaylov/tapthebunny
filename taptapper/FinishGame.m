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
        
        if(IS_WIDESCREEN == NO)
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"finish.plist"];
        }
        else
        {
            [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"finish-five.plist"];
        }
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"mainMenu.plist"];
        
        CCSprite *playBtnSprite = [CCSprite spriteWithSpriteFrameName: @"playBtn.png"];
        CCSprite *playBtnOnSprite = [CCSprite spriteWithSpriteFrameName: @"playBtnOn.png"];
        
        CCSprite *bgSprite = [CCSprite spriteWithSpriteFrameName: [NSString stringWithFormat: @"animal_%i_finish.png", animalNum]];
        bgSprite.position = ccp(GameCenterX, GameCenterY);
        [self addChild: bgSprite];
        
        CCMenuItemImage *mainMenu = [CCMenuItemImage itemWithNormalSprite: playBtnSprite
                                                           selectedSprite: playBtnOnSprite
                                                                   target: self
                                                                 selector: @selector(gotoMainMenu)
                                     ];
        
        mainMenu.position = ccp(GameCenterX * 2 * 0.9, GameCenterY * 2 * 0.15);
        
        CCMenu *menu = [CCMenu menuWithItems: mainMenu, nil];
        menu.position = ccp(0, 0);
        [self addChild: menu];
    }
    
    return self;
}

- (void) gotoMainMenu
{
    CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"SelectAnimal%@.ccbi", postFix]];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
}

@end
