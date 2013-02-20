//
//  MainMenuScene.m
//  doodleCalls
//
//  Created by Vlad on 04.12.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"
#import "CartScene.h"
#import "GameConfig.h"

#import "CCBReader.h"
#import "SimpleAudioEngine.h"
#import "Settings.h"

#import "SHKItem.h"
#import "SHKFacebook.h"
#import "SHKTwitter.h"


@implementation MainMenuScene

- (void) pressedPlay: (id) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    CCScene* selectAnimalScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"SelectAnimal%@.ccbi", postFix]];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: selectAnimalScene]];
}

- (void) pressedShare
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    [self hideSubButtonsWithTag: kSpeedBtnTag andSecondTag: kSoundBtnTag];
    [self hideSlideForButton: 106];
    
    if(!isOpenShareMenu)
    {
        [self showSubButtonsWithTag: kFaceBookBtnTag andSecondTag: kTwitterBtnTag];
        [self showSlideForButton: 105];
    }
    else
    {
        [self hideSubButtonsWithTag: kFaceBookBtnTag andSecondTag: kTwitterBtnTag];
        [self hideSlideForButton: 105];
    }
}

- (void) pressedOptions: (id) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    [self hideSubButtonsWithTag: kFaceBookBtnTag andSecondTag: kTwitterBtnTag];
    [self hideSlideForButton: 105];
    
    
    
    if(!isOpenOptionsMenu)
    {
        [self showButtons: optionBtnsArray];
        //[self showSlideForButton: 106];
    }
    else
    {
        [self hideButtons: optionBtnsArray];
        //[self hideSlideForButton: 106];
    }
}

- (void) pressedCart: (id) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    [self hideSubButtonsWithTag: kFaceBookBtnTag andSecondTag: kTwitterBtnTag];
    [self hideSubButtonsWithTag: kSpeedBtnTag andSecondTag: kSoundBtnTag];
    
    [self hideSlideForButton: 105];
    [self hideSlideForButton: 106];
    
    CCLOG(@"Cart");
    
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: [CartScene scene]]];
}

- (void) sendFB
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    SHKItem *facebookItem = [SHKItem text: @"Best game ever for toddlers and preschoolers!!! #tapthebunny"];
    [SHKFacebook shareItem: facebookItem];
}

- (void) sendTweet
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    SHKItem *tweetItem = [SHKItem text: @"Best game ever for toddlers and preschoolers!!! #tapthebunny"];
    [SHKTwitter shareItem: tweetItem];
}

- (void) soundMode
{
    if ([Settings sharedSettings].soundLevel == 1)
    {
        [Settings sharedSettings].soundLevel = 0;
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: 0];
        [[SimpleAudioEngine sharedEngine] setEffectsVolume: 0];
    }
    else
    {
        [Settings sharedSettings].soundLevel = 1;
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: 1];
        [[SimpleAudioEngine sharedEngine] setEffectsVolume: 1];
    }
    
    [[Settings sharedSettings] save];
}

- (void) speedMode: (CCMenuItem *) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    [Settings sharedSettings].gameMode +=1;
    
    if([Settings sharedSettings].gameMode > 2)
    {
        [Settings sharedSettings].gameMode = 0;
    }
    
    [[Settings sharedSettings] save];
}

- (void) dealloc
{
    [optionBtnsArray release];
    [super dealloc];
}

- (void) didLoadFromCCB
{
    
    
    optionBtnsArray = [[NSMutableArray alloc] init];
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic: @"menu.mp3"];
    if([Settings sharedSettings].soundLevel == 1)
    {
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: 1];
    }
    else
    {
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: 0];
    }
    
    [[SimpleAudioEngine sharedEngine] setEffectsVolume: [Settings sharedSettings].soundLevel];
    
    isOpenOptionsMenu = NO;
    isOpenShareMenu = NO;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: [NSString stringWithFormat: @"mainMenu.plist"]];
    
    CCSprite *options = [CCSprite spriteWithSpriteFrameName: @"optionBtn.png"];
    CCSprite *optionsOn = [CCSprite spriteWithSpriteFrameName: @"optionBtnOn.png"];
    CCSprite *soundOnBtn = [CCSprite spriteWithSpriteFrameName: @"soundOnBtnmm.png"];
    CCSprite *soundOffBtn = [CCSprite spriteWithSpriteFrameName: @"soundOffBtnmm.png"];
    CCSprite *Speed0Btn = [CCSprite spriteWithFile: @"speed0.png"];
    CCSprite *Speed1Btn = [CCSprite spriteWithFile: @"speed1.png"];
    CCSprite *Speed2Btn = [CCSprite spriteWithFile: @"speed2.png"];
    CCSprite *select = [CCSprite spriteWithFile: @"icon.png"];
    
    CCMenuItemImage *optionsBtn = [CCMenuItemImage itemWithNormalSprite: options
                                                         selectedSprite: optionsOn
                                                                 target: self
                                                               selector: @selector(pressedOptions:)];
    
    optionsBtn.position = posForOptionsMenu;
    optionsBtn.tag = 1002;

    CCMenuItemImage *speed0 = [CCMenuItemImage itemWithNormalSprite: Speed0Btn selectedSprite: select];
    CCMenuItemImage *speed1 = [CCMenuItemImage itemWithNormalSprite: Speed1Btn selectedSprite: select];
    CCMenuItemImage *speed2 = [CCMenuItemImage itemWithNormalSprite: Speed2Btn selectedSprite: select];
    
    CCMenuItemImage *on = [CCMenuItemImage itemWithNormalSprite: soundOnBtn selectedSprite: select];
    CCMenuItemImage *off = [CCMenuItemImage itemWithNormalSprite: soundOffBtn selectedSprite: select];
    
    CCMenuItemImage *offBM = [CCMenuItemImage itemWithNormalImage: @"mBMShop.png" selectedImage: @"mBMShop.png"];
    CCMenuItemImage *onBM = [CCMenuItemImage itemWithNormalImage: @"mBMShopOk.png" selectedImage: @"mBMShopOk.png"];
    
    CCMenu *optionMenu = [CCMenu menuWithItems: optionsBtn, nil];
    optionMenu.position = ccp(0, 0);
    [self addChild: optionMenu z: 2 tag: 21];
    
    CCMenu *soundMenu = [CCMenu menuWithItems: nil];
    soundMenu.position = ccp(0, 0);
    [self addChild: soundMenu z:1 tag: -1];
    
    CCMenu *speedMenu = [CCMenu menuWithItems: nil];
    speedMenu.position = ccp(0, 0);
    [self addChild: speedMenu z:1 tag: -1];
        
    CCMenu *babyModeMenu = [CCMenu menuWithItems: nil];
    babyModeMenu.position = ccp(0, 0);
    [self addChild: babyModeMenu z:1 tag: -1];
    
        
    if ([Settings sharedSettings].soundLevel == 0)
    {
        sound = [CCMenuItemToggle itemWithTarget:self
                                                          selector:@selector(soundMode)
                                                             items: off, on, nil
                                   ];
        
        sound.position = posForOptionsMenu;
        sound.isEnabled = NO;
        [soundMenu addChild: sound z: 1 tag: kSoundBtnTag];
    }
    else if ([Settings sharedSettings].soundLevel == 1)
    {
        sound = [CCMenuItemToggle itemWithTarget:self
                                                          selector:@selector(soundMode)
                                                             items: on, off, nil
                                   ];
        
        sound.position = posForOptionsMenu;
        sound.isEnabled = NO;
        [soundMenu addChild: sound z: 1 tag: kSoundBtnTag];
    }
    
    

    
    if ([Settings sharedSettings].gameMode == 0)
    {
        speed = [CCMenuItemToggle itemWithTarget:self
                                                          selector:@selector(speedMode:)
                                                             items: speed0, speed1, speed2, nil
                                   ];
        
        speed.position = posForOptionsMenu;
        speed.isEnabled = NO;
        [speedMenu addChild: speed z: 1 tag: kSpeedBtnTag];
    }
    else if ([Settings sharedSettings].gameMode == 1)
    {
        speed = [CCMenuItemToggle itemWithTarget:self
                                                          selector:@selector(speedMode:)
                                                             items: speed1, speed2, speed0, nil
                                   ];
        
        speed.position = posForOptionsMenu;
        speed.isEnabled = NO;
        [speedMenu addChild: speed z: 1 tag: kSpeedBtnTag];
    }
    else if ([Settings sharedSettings].gameMode == 2)
    {
        speed = [CCMenuItemToggle itemWithTarget:self
                                                          selector:@selector(speedMode:)
                                                             items: speed2, speed0, speed1, nil
                                   ];
        
        speed.position = posForOptionsMenu;
        speed.isEnabled = NO;
        [speedMenu addChild: speed z: 1 tag: kSpeedBtnTag];
    }
    
    CCLOG(@"ENABLEDDD: %i", [Settings sharedSettings].enabledBabyMode);
    ////
    
    if ([Settings sharedSettings].openBabyMode == 0)
    {
        babyMode = [CCMenuItemToggle itemWithTarget:self
                                        selector:@selector(pressedCart:)
                                           items: offBM, nil
                 ];
        
        babyMode.position = posForOptionsMenu;
        babyMode.isEnabled = NO;
        [babyModeMenu addChild: babyMode z: 1 tag: kSoundBtnTag];
    }
    else
    {
        if([Settings sharedSettings].enabledBabyMode == 0)
        {
            babyMode = [CCMenuItemToggle itemWithTarget:self
                                               selector:@selector(selectGameMode)
                                                  items: offBM, onBM, nil
                        ];
            
            babyMode.position = posForOptionsMenu;
            babyMode.isEnabled = NO;
            [babyModeMenu addChild: babyMode z: 1 tag: kSoundBtnTag];
        }
        else
        {
            babyMode = [CCMenuItemToggle itemWithTarget:self
                                               selector:@selector(selectGameMode)
                                                  items: onBM, offBM, nil
                        ];
            
            babyMode.position = posForOptionsMenu;
            babyMode.isEnabled = NO;
            [babyModeMenu addChild: babyMode z: 1 tag: kSoundBtnTag];
        }
    }
    
    [optionBtnsArray addObject: sound];
    [optionBtnsArray addObject: speed];
    [optionBtnsArray addObject: babyMode];
    
    arr = [self children];
    
    CCLOG(@"ENABLED: %i", [Settings sharedSettings].enabledBabyMode);
}

- (void) selectGameMode
{
    if([Settings sharedSettings].enabledBabyMode == 0)
    {
        [Settings sharedSettings].enabledBabyMode = 1;
    }
    else
    {
        [Settings sharedSettings].enabledBabyMode = 0;
    }
    
    [[Settings sharedSettings] save];
    
    CCLOG(@"ENABLED: %i", [Settings sharedSettings].enabledBabyMode);
}

- (void) showSlideForButton: (NSInteger) sliderTag
{
    for(CCNode *mynode in arr)
    {
        if(mynode.tag == sliderTag)
        {
            [mynode runAction: [CCScaleTo actionWithDuration: 0.2 scaleX: 1 scaleY: slideScale]];
        }
    }
}

- (void) hideSlideForButton: (NSInteger) sliderTag
{
    for(CCNode *mynode in arr)
    {
        if(mynode.tag == sliderTag)
        {
            [mynode runAction: [CCScaleTo actionWithDuration: 0.2 scaleX: 1 scaleY: 0]];
        }
    }
}

- (void) showSubButtonsWithTag: (NSInteger) firstTag andSecondTag: (NSInteger) secondTag
{
    if(firstTag == kFaceBookBtnTag)
    {
        isOpenShareMenu = YES;
    }
    if(firstTag == kSpeedBtnTag)
    {
        isOpenOptionsMenu = YES;
    }
    
    for(CCNode *mynode in arr)
    {
        
        if(mynode.tag == -1)
        {
            CCArray *array = [mynode children];
            for(CCMenuItemImage *curNode in array)
            {
                if(curNode.tag == firstTag)
                {
                    [curNode runAction: [CCSequence actions:
                                                        [CCMoveTo actionWithDuration: 0.2
                                                                            position: ccp(curNode.position.x, firstBtnHeight)],
                                         [CCCallBlock actionWithBlock: ^(id sender) {curNode.isEnabled = YES;}], nil]];
                }
                if(curNode.tag == secondTag)
                {
                    [curNode runAction: [CCSequence actions:
                                         [CCMoveTo actionWithDuration: 0.2
                                                             position: ccp(curNode.position.x, secondBtnHeight)],
                                         [CCCallBlock actionWithBlock: ^(id sender) {curNode.isEnabled = YES;}], nil]];
                }
            }
        }
    }
}

- (void) hideSubButtonsWithTag: (NSInteger) firstTag andSecondTag: (NSInteger) secondTag
{
    if(firstTag == kFaceBookBtnTag)
    {
        isOpenShareMenu = NO;
    }
    if(firstTag == kSpeedBtnTag)
    {
        isOpenOptionsMenu = NO;
    }
    
    for(CCNode *mynode in arr)
    {
        if(mynode.tag == -1)
        {
            CCArray *array = [mynode children];
            for(CCMenuItemImage *curNode in array)
            {
                if(curNode.tag == firstTag)
                {
                    [curNode runAction: [CCSequence actions:
                                         [CCMoveTo actionWithDuration: 0.2
                                                             position: ccp(curNode.position.x, startBtnHeight)],
                                         [CCCallBlock actionWithBlock: ^(id sender) {curNode.isEnabled = NO;}], nil]];
                }
                if(curNode.tag == secondTag)
                {
                    [curNode runAction: [CCSequence actions:
                                         [CCMoveTo actionWithDuration: 0.2
                                                             position: ccp(curNode.position.x, startBtnHeight)],
                                         [CCCallBlock actionWithBlock: ^(id sender) {curNode.isEnabled = NO;}], nil]];
                }
            }
        }
    }
}

- (void) showButtons: (NSMutableArray *) buttonsArray
{
    CCNode *cNode = [buttonsArray objectAtIndex: 0];
    
    if(cNode.tag = kSoundBtnTag);
    {
        isOpenOptionsMenu = YES;
    }
    
    for(CCNode *mynode in arr)
    {
        if(mynode.tag == 106)
        {
            [mynode runAction: [CCScaleTo actionWithDuration: 0.2 scaleX: 1 scaleY: 1.25]];
        }
    }
    
    
    for(int i = 0; i < [buttonsArray count]; i++)
    {
        CCMenuItem *node = [buttonsArray objectAtIndex: i];
        
        [node runAction: [CCSequence actions:
                          [CCCallBlock actionWithBlock: ^(id sender) {
        
                                                                        }],
                             [CCMoveTo actionWithDuration: 0.2
                                                 position: ccp(node.position.x, posForOptionsMenu.y + lenght + rasstoyanie * (i + 1))],
                             [CCCallBlock actionWithBlock: ^(id sender) { node.isEnabled = YES; }],
                             nil
                          ]
         ];
    }
}

- (void) hideButtons: (NSMutableArray *) buttonsArray
{
    CCNode *cNode = [buttonsArray objectAtIndex: 0];
    
    if(cNode.tag = kSoundBtnTag);
    {
        isOpenOptionsMenu = NO;
    }
    
    for(CCNode *mynode in arr)
    {
        if(mynode.tag == 106)
        {
            [mynode runAction: [CCScaleTo actionWithDuration: 0.2 scaleX: 1 scaleY: 0]];
        }
    }
    
    for(int i = 0; i < [buttonsArray count]; i++)
    {
        CCMenuItem *node = [buttonsArray objectAtIndex: i];
        
        [node runAction: [CCSequence actions:
                          [CCMoveTo actionWithDuration: 0.2
                                              position: ccp(node.position.x, posForOptionsMenu.y)],
                          [CCCallBlock actionWithBlock: ^(id sender) { node.isEnabled = NO; }],
                          nil
                          ]
         ];
    }

}

@end
