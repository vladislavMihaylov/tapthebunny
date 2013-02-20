//
//  CartScene.m
//  taptapper
//
//  Created by Vlad on 04.02.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Congratulations.h"

#import "GameConfig.h"

#import "CCBReader.h"

#import "Settings.h"

#import "SimpleAudioEngine.h"

@implementation Congratulations

+ (CCScene *) sceneWithStars: (NSInteger) stars
{
    CCScene *scene = [CCScene node];
    
    Congratulations *layer = [[[Congratulations alloc] initWithStars: stars] autorelease];
    
    [scene addChild: layer];
    
    return  scene;
}

- (void) dealloc
{
    [super dealloc];
}

- (id) initWithStars: (NSInteger) stars
{
    if(self = [super init])
    {
        [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
        
        CCSprite *congratulations;
        
        if(stars)
        {
            [[SimpleAudioEngine sharedEngine] playEffect: @"win.mp3"];
            congratulations = [CCSprite spriteWithFile: @"congrats.png"];
            congratulations.position = ccp(GameCenterX, GameCenterY * 1.45);
        }
        else
        {
            [[SimpleAudioEngine sharedEngine] playEffect: @"TryAgain.mp3"];
            congratulations = [CCSprite spriteWithFile: @"tryAgain.png"];
            congratulations.position = ccp(GameCenterX, GameCenterY);
        }
        
        [[SimpleAudioEngine sharedEngine] stopEffect: 2];
        
        CCSprite *bgSprite;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"mainMenu.plist"];
        
        if(IS_WIDESCREEN == YES)
        {
            bgSprite = [CCSprite spriteWithFile: @"congrBg-five.png"];
        }
        else
        {
            bgSprite = [CCSprite spriteWithFile: @"congrBg.png"];
        }
        
        bgSprite.position = ccp(GameCenterX, GameCenterY);
        
        [self addChild: bgSprite];
        
        
        CCSprite *backBtnSprite = [CCSprite spriteWithSpriteFrameName: @"playBtn.png"];
        CCSprite *backBtnOnSprite = [CCSprite spriteWithSpriteFrameName: @"playBtnOn.png"];

        
        CCMenuItemImage *mainMenu = [CCMenuItemImage itemWithNormalSprite: backBtnSprite
                                                           selectedSprite: backBtnOnSprite
                                                                   target: self
                                                                 selector: @selector(gotoMainMenu)
                                     ];
        
        mainMenu.position = ccp(GameCenterX * 2 * 0.9, GameCenterY * 2 * 0.15);
        
        CCMenu *backMenu = [CCMenu menuWithItems: mainMenu, nil];
        backMenu.position = ccp(0, 0);
        
        [self addChild: backMenu];
        
        
        
        
        [self addChild: congratulations];
        
        CCSprite *starSprite1 = [CCSprite spriteWithFile: @"star.png"];
        
        float startPosition = GameCenterX + (starSprite1.contentSize.width * 1.5 / 2 * (stars - 1));
        
        for(int i = 0; i < stars; i++)
        {
            CCSprite *starSprite = [CCSprite spriteWithFile: @"star.png"];
            
            starSprite.position = ccp((startPosition - (i * starSprite.contentSize.width * 1.5)), GameCenterY * 1.05);
            starSprite.scale = 1.5;
            [self addChild: starSprite];
        }
    }
    
    return self;
}

- (void) gotoMainMenu
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    if(IS_WIDESCREEN == YES)
    {
        CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: @"SelectAnimal-five.ccbi"];
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
    }
    else
    {
        CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: @"SelectAnimal.ccbi"];
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
    }
}

@end
