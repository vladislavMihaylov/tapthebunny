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

#import "MKStoreManager.h"

#import "Chartboost.h"

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

        [[Chartboost sharedChartboost] showInterstitial];
        
        [MKStoreManager sharedManager].delegate = self;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"selectAnimal.plist"];
        
        CCSprite *backBtnSprite = [CCSprite spriteWithSpriteFrameName: @"backBtn.png"];
        CCSprite *backBtnOnSprite = [CCSprite spriteWithSpriteFrameName: @"backBtnOn.png"];
        
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
        
        ///////////////////////////////////////////////////////////////////////////
        
        animalsPackBuyed = [CCSprite spriteWithFile: @"animalsShopOk.png"];
        animalsPackBuyed.position = ccp(GameCenterX * 0.75, GameCenterY * 1.1);
        animalsPackBuyed.visible = NO;
        [self addChild: animalsPackBuyed];
        
        babyModeBuyed = [CCSprite spriteWithFile: @"BMShopOk.png"];
        babyModeBuyed.position = ccp(GameCenterX * 1.25, GameCenterY * 1.1);
        babyModeBuyed.visible = NO;
        [self addChild: babyModeBuyed];
        
        
        
        if([MKStoreManager featureAPurchased])
        {
            animalsPackBuyed.visible = YES;
            
            animalsMenu.isTouchEnabled = NO;
            animalsMenu.visible = NO;
        }
        else
        {
            animalsPackBuyed.visible = NO;
            
            CCMenuItemImage *animalsPack = [CCMenuItemImage itemWithNormalImage: @"animalsShop.png"
                                                                  selectedImage: @"animalsShop.png"
                                                                         target: self
                                                                       selector: @selector(buy:)
                                            ];
            animalsPack.position = ccp(GameCenterX * 0.75, GameCenterY * 1.1);
            animalsPack.tag = 1;
            
            animalsMenu = [CCMenu menuWithItems: animalsPack, nil];
            animalsMenu.position = ccp(0, 0);
            [self addChild: animalsMenu];
            
            
        }
        
        if ([MKStoreManager featureBPurchased]) // если куплена фича 2
        {
            babyModeBuyed.visible = YES;
            
            babyModeMenu.isTouchEnabled = NO;
            babyModeMenu.visible = NO;
        }
        else
        {
            babyModeBuyed.visible = NO;
            
            CCMenuItemImage *babyMode = [CCMenuItemImage itemWithNormalImage: @"BMShop.png"
                                                               selectedImage: @"BMShop.png"
                                                                      target: self
                                                                    selector: @selector(buy:)
                                         ];
            babyMode.position = ccp(GameCenterX * 1.25, GameCenterY * 1.1);
            babyMode.tag = 2;
            
            babyModeMenu = [CCMenu menuWithItems: babyMode, nil];
            babyModeMenu.position = ccp(0, 0);
            [self addChild: babyModeMenu];
        }
        
        
        CCMenuItemImage *mainMenu = [CCMenuItemImage itemWithNormalSprite: backBtnSprite
                                                           selectedSprite: backBtnOnSprite
                                                                   target: self
                                                                 selector: @selector(gotoMainMenu)
                                     ];
        
        mainMenu.position = ccp(GameCenterX * 0.2, GameCenterY * 0.3);
        
        backMenu = [CCMenu menuWithItems: mainMenu, nil];
        backMenu.position = ccp(0, 0);
        [self addChild: backMenu];
        
        CCMenuItemImage *restoreBtn = [CCMenuItemImage itemWithNormalImage: @"restoreBtn.png"
                                                             selectedImage: @"restoreBtnTap.png"
                                                                    target: self
                                                                  selector: @selector(restorePurshase)];
        
        restoreBtn.position = ccp(GameCenterX * 1.8, GameCenterY * 0.3);
        
        restoreMenu = [CCMenu menuWithItems: restoreBtn, nil];
        restoreMenu.position = ccp(0, 0);
        
        [self addChild: restoreMenu];
        
        CCSprite *shopLabel = [CCSprite spriteWithFile: @"shopLabel.png"];
        shopLabel.position = ccp(GameCenterX, GameCenterY * 1.7);
        [self addChild: shopLabel];
        
        CCSprite *cost099 = [CCSprite spriteWithFile: @"099.png"];
        cost099.position = ccp(GameCenterX * 0.75, GameCenterY * 0.7);
        [self addChild: cost099];
        
        CCSprite *cost199 = [CCSprite spriteWithFile: @"199.png"];
        cost199.position = ccp(GameCenterX * 1.25, GameCenterY * 0.7);
        [self addChild: cost199];
        
        //[self setPrice];
    }
    
    return self;
}

#pragma mark Methods for purshase


- (void) restorePurshase
{
    [self lockMenu];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    
}

- (void) buy: (CCMenuItemImage *) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    if(sender.tag == 1)
    {
        [self lockMenu];
        
        [[MKStoreManager sharedManager] buyFeatureA];
    }
    
    if(sender.tag == 2)
    {
        [self lockMenu];
        
        [[MKStoreManager sharedManager] buyFeatureB];
    }
}

- (void) lockMenu
{
    CCLayerColor *blockLayer = [CCLayerColor layerWithColor: ccc4(0, 0, 0, 128)];
    [self addChild: blockLayer z: 10 tag: 321];
    
    CCLabelTTF *loading = [CCLabelTTF labelWithString: @"Loading" fontName: @"Arial" fontSize: 36];
    loading.position = ccp(GameCenterX, GameCenterY);
    loading.color = ccc3(255, 255, 255);
    [self addChild: loading z:11 tag:322];
    
    animalsMenu.isTouchEnabled = NO;
    babyModeMenu.isTouchEnabled = NO;
    backMenu.isTouchEnabled = NO;
    restoreMenu.isTouchEnabled = NO;
}

- (void) unlockMenu
{
    [self removeChildByTag: 321 cleanup: YES];
    [self removeChildByTag: 322 cleanup: YES];
    
    animalsMenu.isTouchEnabled = YES;
    babyModeMenu.isTouchEnabled = YES;
    backMenu.isTouchEnabled = YES;
    restoreMenu.isTouchEnabled = YES;
}

- (void)productAPurchased
{
    [self unlockMenu];
    
    animalsPackBuyed.visible = YES;
    animalsMenu.isTouchEnabled = NO;
    animalsMenu.visible = NO;
    
    babyModeMenu.isTouchEnabled = YES;
    backMenu.isTouchEnabled = YES;
}

- (void)productBPurchased
{
    [self unlockMenu];
    
    babyModeBuyed.visible = YES;
    babyModeMenu.isTouchEnabled = NO;
    babyModeMenu.visible = NO;
    
    animalsMenu.isTouchEnabled = YES;
    backMenu.isTouchEnabled = YES;
    
    [Settings sharedSettings].openBabyMode = 1;
    [Settings sharedSettings].enabledBabyMode = 1;
    [[Settings sharedSettings] save];
}

- (void)failed
{
    [self unlockMenu];
}

#pragma mark Navigation

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
        CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"MainMenuScene%@.ccbi", postFix]];
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
    }
    
}

@end
