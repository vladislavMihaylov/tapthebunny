//
//  CartScene.m
//  taptapper
//
//  Created by Vlad on 04.02.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "CartScene.h"

#import "GameConfig.h"

#import "CCBReader.h"

#import "Settings.h"

#import "SimpleAudioEngine.h"

@implementation CartScene

+ (CCScene *) scene
{
    CCScene *scene = [CCScene node];
    
    CartScene *layer = [CartScene node];
    
    [scene addChild: layer];
    
    return  scene;
}

- (void) dealloc
{
    [super dealloc];
}

- (id) init
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
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"selectAnimal.plist"];
        
        CCSprite *backBtnSprite = [CCSprite spriteWithSpriteFrameName: @"backBtn.png"];
        CCSprite *backBtnOnSprite = [CCSprite spriteWithSpriteFrameName: @"backBtnOn.png"];
        
        //
        CCMenu *menu = [CCMenu menuWithItems: nil];
        menu.position = ccp(0, 0);
        [self addChild: menu];
        
        
        CCMenuItemImage *buyOwl = [CCMenuItemImage itemWithNormalImage: @"animalsShop.png"
                                                         selectedImage: @"animalsShop.png"
                                                                target: self
                                                              selector: @selector(buy:)
                                   ];
        
        CCMenuItemImage *buyOwlOk = [CCMenuItemImage itemWithNormalImage: @"animalsShopOk.png"
                                                           selectedImage: @"animalsShopOk.png"
                                                                  target: self
                                                                selector: @selector(buy:)
                                   ];
        
        CCMenuItemImage *buySquirrel = [CCMenuItemImage itemWithNormalImage: @"BMShop.png"
                                                              selectedImage: @"BMShop.png"
                                                                     target: self
                                                                   selector: @selector(buy:)
                                   ];
        
        CCMenuItemImage *buySquirrelOk = [CCMenuItemImage itemWithNormalImage: @"BMShopOk.png"
                                                                selectedImage: @"BMShopOk.png"
                                                                       target: self
                                                                     selector: @selector(buy:)
                                     ];
        
        if ([Settings sharedSettings].openAnimals == 0)
        {
            CCMenuItemToggle *owl = [CCMenuItemToggle itemWithTarget: self selector: @selector(buy:) items: buyOwl, buyOwlOk, nil];
            owl.position = ccp(GameCenterX * 0.75, GameCenterY * 1.1);
            owl.tag = 1;
            [menu addChild: owl];
            
        }
        else
        {
            CCMenuItemToggle *owl = [CCMenuItemToggle itemWithTarget: self selector: @selector(buy:) items: buyOwlOk, buyOwl, nil];
            owl.position = ccp(GameCenterX * 0.75, GameCenterY * 1.1);
            owl.tag = 1;
            [menu addChild: owl];
            
        }
        
        if ([Settings sharedSettings].openBabyMode == 0)
        {
            CCMenuItemToggle *squirrel = [CCMenuItemToggle itemWithTarget: self selector: @selector(buy:) items: buySquirrel, buySquirrelOk, nil];
            squirrel.position = ccp(GameCenterX * 1.25, GameCenterY * 1.1);
            squirrel.tag = 2;
            [menu addChild: squirrel];
        }
        else
        {
            CCMenuItemToggle *squirrel = [CCMenuItemToggle itemWithTarget: self selector: @selector(buy:) items: buySquirrelOk, buySquirrel, nil];
            squirrel.position = ccp(GameCenterX * 1.25, GameCenterY * 1.1);
            squirrel.tag = 2;
            [menu addChild: squirrel];
        }

        
        CCMenuItemImage *mainMenu = [CCMenuItemImage itemWithNormalSprite: backBtnSprite
                                                           selectedSprite: backBtnOnSprite
                                                                   target: self
                                                                 selector: @selector(gotoMainMenu)
                                     ];
        
        mainMenu.position = ccp(GameCenterX * 0.2, GameCenterY * 0.3);
        
        CCMenu *backMenu = [CCMenu menuWithItems: mainMenu, nil];
        backMenu.position = ccp(0, 0);
        [self addChild: backMenu];
        
        for(int i = 0; i < 2; i++)
        {
            CCLabelBMFont *cost = [CCLabelBMFont labelWithString: [NSString stringWithFormat: @"%i,99$", i] fntFile: @"bip.fnt"];
            cost.position = ccp((GameCenterX / 2) * (i + 1) + GameCenterX/4, GameCenterY * 0.65);
            [self addChild: cost];
        }
        
        CCLabelBMFont *shopLabel = [CCLabelBMFont labelWithString: @"Shop" fntFile: @"shopFnt.fnt"];
        shopLabel.position = ccp(GameCenterX, GameCenterY * 1.7);
        [self addChild: shopLabel];
    }
    
    return self;
}

- (void) buy: (CCMenuItemToggle *) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    if(sender.tag == 1)
    {
        [Settings sharedSettings].openAnimals = ![Settings sharedSettings].openAnimals;
        
        [[Settings sharedSettings] save];
    }
    if(sender.tag == 2)
    {
        [Settings sharedSettings].openBabyMode = ![Settings sharedSettings].openBabyMode;
        
        [[Settings sharedSettings] save];
    }
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
