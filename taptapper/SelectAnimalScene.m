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
#import "Common.h"

@implementation SelectAnimalScene

- (void) back
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: @"MainMenuScene-ipad.ccbi"];
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
    }
    else
    {
        CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: @"MainMenuScene.ccbi"];
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
    }
}

- (void) playWith: (CCMenuItemImage *) sender
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: [GameLayer sceneWithAnimal: sender.tag]]];
    
}

- (void) didLoadFromCCB
{
    CCSprite *sprite = [CCSprite spriteWithFile: @"Icon.png"];
    sprite.anchorPoint = ccp(0.5, 0);
    
    CCSprite *sprite2 = [CCSprite spriteWithFile: @"Icon.png"];
    sprite2.anchorPoint = ccp(0.5, 0);
    
    CCSprite *sprite3 = [CCSprite spriteWithFile: @"Icon.png"];
    sprite3.anchorPoint = ccp(0.5, 0);
   
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        sprite.position = ccp(200, 223);
        sprite2.position = ccp(512, 223);
        sprite3.position = ccp(824, 223);
    }
    else
    {
        sprite.position = ccp(90, 84);
        sprite2.position = ccp(240, 84);
        sprite3.position = ccp(390, 84);
    }
    
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
