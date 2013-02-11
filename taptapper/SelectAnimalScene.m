//
//  SelectAnimalScene.m
//  taptapper
//
//  Created by Vlad on 26.01.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SelectAnimalScene.h"
#import "CCBReader.h"

#import "GameLayer.h"
#import "GameConfig.h"
#import "Common.h"

#import "FinishGame.h"

#import "SimpleAudioEngine.h"
#import "Settings.h"

#import "MKStoreManager.h"

@implementation SelectAnimalScene

- (void) back
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"MainMenuScene%@.ccbi", postFix]];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
}

- (void) playWith: (CCMenuItemImage *) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    animalNum = sender.tag;
    
    if(animalNum == 1)
    {
        CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"gameScene_%i%@.ccbi", sceneNum, postFix]];
        
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
    }
    
    if(animalNum == 2 || animalNum == 3)
    {
        if([MKStoreManager featureAPurchased])
        {
            CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"gameScene_%i%@.ccbi", sceneNum, postFix]];
            
            [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
        }
        
        else
        {
            [[MKStoreManager sharedManager] buyFeatureA];
            [self lockMenu];
            
        }
    }
}

- (void) lockMenu
{
    for(CCMenu *curMenu in arr)
    {
        curMenu.isTouchEnabled = NO;
    }
}

- (void) unlockMenu
{
    for(CCMenu *curMenu in arr)
    {
        curMenu.isTouchEnabled = YES;
    }
}

- (void)productAPurchased
{
    [self unlockMenu];
    [self playAnimalsAnimation];
}

- (void)failed
{
    [self unlockMenu];
}

- (void) dealloc
{
    [super dealloc];
}

- (void) didLoadFromCCB
{
    arr = [self children];
    [MKStoreManager sharedManager].delegate = self;
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic: @"chooseAnimal.mp3"];
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: [Settings sharedSettings].soundLevel];
    
    sceneNum = arc4random() % 3 + 1;
    
    CCSprite *sprite = [CCSprite spriteWithFile: @"Icon.png"];
    sprite.anchorPoint = ccp(0.5, 0);
    
    sprite2 = [CCSprite spriteWithFile: @"animal_2_lock.png"];
    sprite2.anchorPoint = ccp(0.5, 0);
    
    sprite3 = [CCSprite spriteWithFile: @"animal_3_lock.png"];
    sprite3.anchorPoint = ccp(0.5, 0);
   
    sprite.position = posForSprite1;
    sprite2.position = posForSprite2;
    sprite3.position = posForSprite3;
    
    [self addChild: sprite];
    [self addChild: sprite2];
    [self addChild: sprite3];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"buttonsAnimations.plist"];
    
    [Common loadAnimationWithPlist: @"btnAnimation" andName: [NSString stringWithFormat: @"bunnyAnimation"]];
    [Common loadAnimationWithPlist: @"btnAnimation" andName: [NSString stringWithFormat: @"squirrelAnimation"]];
    [Common loadAnimationWithPlist: @"btnAnimation" andName: [NSString stringWithFormat: @"owlAnimation"]];
    
    [sprite runAction:
            [CCRepeatForever actionWithAction:
                                [CCAnimate actionWithAnimation:
                                        [[CCAnimationCache sharedAnimationCache] animationByName: @"bunnyAnimation"]
                                 ]
             ]
     ];
    
    if([MKStoreManager featureAPurchased])
    {
        [self playAnimalsAnimation];
    }
}

- (void) playAnimalsAnimation
{
    [sprite2 runAction:
                [CCRepeatForever actionWithAction:
                                    [CCAnimate actionWithAnimation:
                                            [[CCAnimationCache sharedAnimationCache] animationByName: @"owlAnimation"]
                                     ]
                 ]
         ];
    
    [sprite3 runAction:
            [CCRepeatForever actionWithAction:
                                [CCAnimate actionWithAnimation:
                                        [[CCAnimationCache sharedAnimationCache] animationByName: @"squirrelAnimation"]
                                 ]
             ]
     ];
}

@end
