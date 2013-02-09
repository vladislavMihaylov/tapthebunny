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
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"selectAnimal.plist"];
        
        CCSprite *bgSprite;
        
        if(IS_WIDESCREEN == YES)
        {
            bgSprite = [CCSprite spriteWithFile: @"selectAnimalBg.png"];
        }
        else
        {
            bgSprite = [CCSprite spriteWithSpriteFrameName: @"bg.png"];
        }
        
        bgSprite.position = ccp(GameCenterX, GameCenterY);
        
        [self addChild: bgSprite];
        
        
        CCSprite *backBtnSprite = [CCSprite spriteWithSpriteFrameName: @"backBtn.png"];
        CCSprite *backBtnOnSprite = [CCSprite spriteWithSpriteFrameName: @"backBtnOn.png"];

        
        CCMenuItemImage *mainMenu = [CCMenuItemImage itemWithNormalSprite: backBtnSprite
                                                           selectedSprite: backBtnOnSprite
                                                                   target: self
                                                                 selector: @selector(gotoMainMenu)
                                     ];
        
        mainMenu.position = ccp(GameCenterX * 0.2, GameCenterY * 0.3);
        
        CCMenu *backMenu = [CCMenu menuWithItems: mainMenu, nil];
        backMenu.position = ccp(0, 0);
        [self addChild: backMenu];
        
        
        
        CCLabelBMFont *congratulationsLabel = [CCLabelBMFont labelWithString: @"Congratulations!" fntFile: @"shopFnt.fnt"];
        congratulationsLabel.position = ccp(GameCenterX, GameCenterY * 1.7);
        
        if(stars)
        {
            [self addChild: congratulationsLabel];
        }
        
        NSString *text;
        
        if(stars == 0)
        {
            text = @"You not collected stars!";
        }
        else
        {
            text = @"You collected:";
        }
        
        CCLabelBMFont *collectedLabel = [CCLabelBMFont labelWithString: [NSString stringWithFormat: @"%@", text] fntFile: @"shopFnt.fnt"];
        
        if(stars)
        {
            collectedLabel.position = ccp(GameCenterX, GameCenterY * 1.35);
            collectedLabel.scale = 0.85;
        }
        else
        {
            collectedLabel.position = ccp(GameCenterX, GameCenterY);
        }
        
        
        [self addChild: collectedLabel];
        
        NSString *postFix;
        
        if(stars > 1)
        {
            postFix = @"s!";
        }
        else
        {
            postFix = @"!";
        }
        
        CCLabelBMFont *starsLabel = [CCLabelBMFont labelWithString: [NSString stringWithFormat: @"star%@", postFix] fntFile: @"shopFnt.fnt"];
        starsLabel.position = ccp(GameCenterX, GameCenterY * 0.75);
        starsLabel.scale = 0.85;
        
        if(stars)
        {
            [self addChild: starsLabel];
        }
        
        CCSprite *starSprite1 = [CCSprite spriteWithFile: @"star.png"];
        
        float startPosition = GameCenterX + (starSprite1.contentSize.width / 2 * (stars - 1));
        
        for(int i = 0; i < stars; i++)
        {
            CCSprite *starSprite = [CCSprite spriteWithFile: @"star.png"];
            
            starSprite.position = ccp((startPosition - (i * starSprite.contentSize.width)), GameCenterY * 1.05);
            
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
        CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: @"MainMenuScene-five.ccbi"];
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
    }
    else
    {
        CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: @"MainMenuScene.ccbi"];
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
    }
    
    
    
}

@end
