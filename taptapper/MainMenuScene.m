//
//  MainMenuScene.m
//  doodleCalls
//
//  Created by Vlad on 04.12.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"

#import "CCBReader.h"

#import "SimpleAudioEngine.h"

#import "GameConfig.h"
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
        [self showSubButtonsWithTag: kSpeedBtnTag andSecondTag: kSoundBtnTag];
        [self showSlideForButton: 106];
    }
    else
    {
        [self hideSubButtonsWithTag: kSpeedBtnTag andSecondTag: kSoundBtnTag];
        [self hideSlideForButton: 106];
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
}

- (void) pressedGift: (id) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    [self hideSubButtonsWithTag: kFaceBookBtnTag andSecondTag: kTwitterBtnTag];
    [self hideSubButtonsWithTag: kSpeedBtnTag andSecondTag: kSoundBtnTag];
    
    [self hideSlideForButton: 105];
    [self hideSlideForButton: 106];
}

- (void) sendFB
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    SHKItem *facebookItem = [SHKItem text: @"Best game ever!!! #tapthebunny"];
    [SHKFacebook shareItem: facebookItem];
}

- (void) sendTweet
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    SHKItem *tweetItem = [SHKItem text: @"Best game ever!!! #tapthebunny"];
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

- (void) speedMode
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    if ([Settings sharedSettings].gameMode == 1)
    {
        [Settings sharedSettings].gameMode = 0;
    }
    else
    {
        [Settings sharedSettings].gameMode = 1;
    }
    
    [[Settings sharedSettings] save];
}

- (void) didLoadFromCCB
{
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic: @"menu.mp3"];
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: [Settings sharedSettings].soundLevel];
    [[SimpleAudioEngine sharedEngine] setEffectsVolume: [Settings sharedSettings].soundLevel];
    
    isOpenOptionsMenu = NO;
    isOpenShareMenu = NO;
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: [NSString stringWithFormat: @"mainMenu.plist"]];
    
    CCSprite *options = [CCSprite spriteWithSpriteFrameName: @"optionBtn.png"];
    CCSprite *optionsOn = [CCSprite spriteWithSpriteFrameName: @"optionBtnOn.png"];
    CCSprite *soundOnBtn = [CCSprite spriteWithSpriteFrameName: @"soundOnBtnmm.png"];
    CCSprite *soundOffBtn = [CCSprite spriteWithSpriteFrameName: @"soundOffBtnmm.png"];
    CCSprite *babySpeedBtn = [CCSprite spriteWithSpriteFrameName: @"speed1Btn.png"];
    CCSprite *monsterSpeedBtn = [CCSprite spriteWithSpriteFrameName: @"speed2Btn.png"];
    CCSprite *select = [CCSprite spriteWithFile: @"icon.png"];
    
    CCMenuItemImage *optionsBtn = [CCMenuItemImage itemWithNormalSprite: options
                                                         selectedSprite: optionsOn
                                                                 target: self
                                                               selector: @selector(pressedOptions:)];
    
    optionsBtn.position = posForOptionsMenu;

    
    CCMenuItemImage *on = [CCMenuItemImage itemWithNormalSprite: soundOnBtn selectedSprite: select];
    CCMenuItemImage *off = [CCMenuItemImage itemWithNormalSprite: soundOffBtn selectedSprite: select];
    
    CCMenuItemImage *baby = [CCMenuItemImage itemWithNormalSprite: babySpeedBtn selectedSprite: select];
    CCMenuItemImage *monster = [CCMenuItemImage itemWithNormalSprite: monsterSpeedBtn selectedSprite: select];
    
    CCMenu *optionMenu = [CCMenu menuWithItems: optionsBtn, nil];
    optionMenu.position = ccp(0, 0);
    [self addChild: optionMenu z: 2 tag: 21];
    
    CCMenu *soundMenu = [CCMenu menuWithItems: nil];
    soundMenu.position = ccp(0, 0);
    [self addChild: soundMenu z:1 tag: -1];
    
    CCMenu *speedMenu = [CCMenu menuWithItems: nil];
    speedMenu.position = ccp(0, 0);
    [self addChild: speedMenu z:1 tag: -1];
    
    CCLOG(@"gameMode: %i", [Settings sharedSettings].gameMode);
    CCLOG(@"soundMode: %i", [Settings sharedSettings].soundLevel);
    
    if ([Settings sharedSettings].soundLevel == 0)
    {
        CCMenuItemToggle *sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundMode) items: off, on, nil];
        sound.position = posForOptionsMenu;
        sound.isEnabled = NO;
        [soundMenu addChild: sound z: 1 tag: kSoundBtnTag];
    }
    else if ([Settings sharedSettings].soundLevel == 1)
    {
        CCMenuItemToggle *sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundMode) items: on, off, nil];
        sound.position = posForOptionsMenu;
        sound.isEnabled = NO;
        [soundMenu addChild: sound z: 1 tag: kSoundBtnTag];
    }
    
    
    if ([Settings sharedSettings].gameMode == 0)
    {
        CCMenuItemToggle *speed = [CCMenuItemToggle itemWithTarget:self selector:@selector(speedMode) items: baby, monster, nil];
        speed.position = posForOptionsMenu;
        speed.isEnabled = NO;
        [speedMenu addChild: speed z: 1 tag: kSpeedBtnTag];
    }
    else if ([Settings sharedSettings].gameMode == 1)
    {
        CCMenuItemToggle *speed = [CCMenuItemToggle itemWithTarget:self selector:@selector(speedMode) items: monster, baby, nil];
        speed.position = posForOptionsMenu;
        speed.isEnabled = NO;
        [speedMenu addChild: speed z: 1 tag: kSpeedBtnTag];
    }
    
    arr = [self children];
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

@end
