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
    
    CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"gameScene_%i%@.ccbi", sceneNum, postFix]];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
}

- (void) didLoadFromCCB
{
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic: @"chooseAnimal.mp3"];
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: [Settings sharedSettings].soundLevel];
    
    sceneNum = arc4random() % 3 + 1;
    
    CCSprite *sprite = [CCSprite spriteWithFile: @"Icon.png"];
    sprite.anchorPoint = ccp(0.5, 0);
    
    CCSprite *sprite2 = [CCSprite spriteWithFile: @"Icon.png"];
    sprite2.anchorPoint = ccp(0.5, 0);
    
    CCSprite *sprite3 = [CCSprite spriteWithFile: @"Icon.png"];
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
