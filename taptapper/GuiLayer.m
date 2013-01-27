//
//  GuiLayer.m
//  taptapper
//
//  Created by Vlad on 27.01.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GuiLayer.h"
#import "GameLayer.h"

@implementation GuiLayer

@synthesize gameLayer;

- (void) dealloc
{
    [super dealloc];
}

- (id) init
{
    if(self = [super init])
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
        
        batchNode = [CCSpriteBatchNode batchNodeWithFile: @"pauseMenu.png"];
        [self addChild: batchNode];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: @"pauseMenu.plist"];
        
        boxSprite = [CCSprite spriteWithSpriteFrameName: @"menuBox.png"];
        boxSprite.anchorPoint = ccp(0, 0);
        boxSprite.position = ccp(screenWidth + 10, 0);
        [self addChild: boxSprite];
        
        pauseBtn = [CCSprite spriteWithSpriteFrameName: @"pauseBtn.png"];
        pauseBtnOn = [CCSprite spriteWithSpriteFrameName: @"pauseBtnOn.png"];
        
        hideMenuBtn = [CCSprite spriteWithSpriteFrameName: @"arrowBtn.png"];
        hideMenuBtnOn = [CCSprite spriteWithSpriteFrameName: @"arrowBtnOn.png"];
        
        restartBtn = [CCSprite spriteWithSpriteFrameName: @"restartBtn.png"];
        restartBtnOn = [CCSprite spriteWithSpriteFrameName: @"restartBtnOn.png"];
        
        homeBtn = [CCSprite spriteWithSpriteFrameName: @"homeBtn.png"];
        homeBtnOn = [CCSprite spriteWithSpriteFrameName: @"homeBtnOn.png"];
        
        selectBtn = [CCSprite spriteWithSpriteFrameName: @"selectAnimalBtn.png"];
        selectBtnOn = [CCSprite spriteWithSpriteFrameName: @"selectAnimalBtnOn.png"];
        
        soundBtnOn = [CCSprite spriteWithSpriteFrameName: @"soundOnBtn.png"];
        soundBtnOff = [CCSprite spriteWithSpriteFrameName: @"soundOffBtn.png"];
        
        tutorialBtn = [CCSprite spriteWithSpriteFrameName: @"tutorialBtn.png"];
        tutorialBtnOn = [CCSprite spriteWithSpriteFrameName: @"tutorialBtnOn.png"];
        
        other = [CCSprite spriteWithFile: @"icon.png"];
        other2 = [CCSprite spriteWithFile: @"icon.png"];
        
        CCMenuItemImage *pauseBtnMenu = [CCMenuItemImage itemWithNormalSprite: pauseBtn
                                                               selectedSprite: pauseBtnOn
                                                                       target: self
                                                                     selector: @selector(showPauseMenu)
                                         ];
        
        pauseBtnMenu.position = ccp(screenWidth - pauseBtnMenu.contentSize.width * 0.65,
                                    screenHeight - pauseBtnMenu.contentSize.height * 0.65);
        
        CCMenu *guiMenu = [CCMenu menuWithItems: pauseBtnMenu, nil];
        guiMenu.position = ccp(0, 0);
        [self addChild: guiMenu];
        
        
        CCMenu *soundMenu = [CCMenu menuWithItems: nil];
        soundMenu.position = ccp(0, 0);
        [boxSprite addChild: soundMenu];
        
        CCMenuItemImage *soundOn = [CCMenuItemImage itemWithNormalSprite: soundBtnOn
                                                          selectedSprite: other
                                    ];
        
        CCMenuItemImage *soundOff = [CCMenuItemImage itemWithNormalSprite: soundBtnOff
                                                           selectedSprite: other2
                                     ];
        
        //if ([Settings sharedSettings].soundLevel == 1)
        //{
            CCMenuItemToggle *soundMode = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundMode) items: soundOn, soundOff, nil];
            
            [soundMenu addChild: soundMode];
        //}
        //else if ([Settings sharedSettings].soundLevel == 2)
        //{
        //    CCMenuItemToggle *difficulty = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundMode) items: off, on, nil];
        //    difficulty.position = ccp(50, 175);
        //    [difficultyMenu addChild:difficulty];
        //}
        
        
        CCMenuItemImage *hideMenu = [CCMenuItemImage itemWithNormalSprite: hideMenuBtn
                                                           selectedSprite: hideMenuBtnOn
                                                                   target: self
                                                                 selector: @selector(hidePauseMenu)
                                     ];
        
        CCMenuItemImage *restart = [CCMenuItemImage itemWithNormalSprite: restartBtn
                                                          selectedSprite:restartBtnOn
                                    ];
        
        CCMenuItemImage *mainMenu = [CCMenuItemImage itemWithNormalSprite: homeBtn
                                                           selectedSprite: homeBtnOn
                                     ];
        
        CCMenuItemImage *selectAnimalMenu = [CCMenuItemImage itemWithNormalSprite: selectBtn
                                                                   selectedSprite: selectBtnOn
                                             ];
        
        CCMenuItemImage *tutorial = [CCMenuItemImage itemWithNormalSprite: tutorialBtn
                                                           selectedSprite: tutorialBtnOn
                                     ];
        
        CCMenu *pauseMenu = [CCMenu menuWithItems: hideMenu, restart, mainMenu, selectAnimalMenu, tutorial, nil];
        pauseMenu.position = ccp(0, 0);
        [boxSprite addChild: pauseMenu];
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            soundMode.position = ccp(60, 40);
            hideMenu.position = ccp(5, 90);
            restart.position = ccp(89, 140);
            mainMenu.position = ccp(60, 90);
            selectAnimalMenu.position = ccp(120, 90);
            tutorial.position = ccp(120, 40);
        }
        else
        {
            soundMode.position = ccp(120, 80);
            hideMenu.position = ccp(15, 180);
            restart.position = ccp(178, 280);
            mainMenu.position = ccp(120, 180);
            selectAnimalMenu.position = ccp(240, 180);
            tutorial.position = ccp(240, 80);
        }
    }
    
    return self;
}

- (void) showPauseMenu
{
    [boxSprite runAction: [CCMoveTo actionWithDuration: 0.5 position: ccp(screenWidth - boxSprite.contentSize.width, 0)]];
}

- (void) hidePauseMenu
{
    [boxSprite runAction: [CCMoveTo actionWithDuration: 0.5 position: ccp(screenWidth + 10, 0)]];
}

- (void) soundMode
{
    
}

@end
