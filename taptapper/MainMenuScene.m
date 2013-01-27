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

#import "SHKItem.h"
#import "SHKFacebook.h"
#import "SHKTwitter.h"

@implementation MainMenuScene

- (void) pressedPlay: (id) sender
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        CCScene* selectAnimalScene = [CCBReader sceneWithNodeGraphFromFile: @"SelectAnimal-ipad.ccbi"];
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: selectAnimalScene]];
    }
    else
    {
        CCScene* selectAnimalScene = [CCBReader sceneWithNodeGraphFromFile: @"SelectAnimalScene.ccbi"];
        [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: selectAnimalScene]];
    }
}

- (void) pressedShare
{
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
    [self hideSubButtonsWithTag: kFaceBookBtnTag andSecondTag: kTwitterBtnTag];
    [self hideSubButtonsWithTag: kSpeedBtnTag andSecondTag: kSoundBtnTag];
    
    [self hideSlideForButton: 105];
    [self hideSlideForButton: 106];
    
    CCLOG(@"Cart");
}

- (void) pressedGift: (id) sender
{
    [self hideSubButtonsWithTag: kFaceBookBtnTag andSecondTag: kTwitterBtnTag];
    [self hideSubButtonsWithTag: kSpeedBtnTag andSecondTag: kSoundBtnTag];
    
    [self hideSlideForButton: 105];
    [self hideSlideForButton: 106];
}

- (void) sendFB
{
    SHKItem *facebookItem = [SHKItem text: @"Best game ever!!! #tapthebunny"];
    [SHKFacebook shareItem: facebookItem];
}

- (void) sendTweet
{
    SHKItem *tweetItem = [SHKItem text: @"Best game ever!!! #tapthebunny"];
    [SHKTwitter shareItem: tweetItem];
}

- (void) soundMode
{
    CCLOG(@"Sound");
}

- (void) speedMode
{
    CCLOG(@"Speed");
}

- (void) didLoadFromCCB
{
    isOpenOptionsMenu = NO;
    isOpenShareMenu = NO;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        startHeight = 80;
        firstBtnHeight = 185;
        secondBtnHeight = 260;
        
        slideScale = 0.9;
        
        CCLOG(@"iPad");
    }
    else
    {
        startHeight = 50;
        firstBtnHeight = 110;
        secondBtnHeight = 150;
        
        slideScale = 1;
        
        CCLOG(@"iPhone");
    }
    
    
}

- (void) showSlideForButton: (NSInteger) sliderTag
{
    CCArray *arr = [self children];
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
    CCArray *arr = [self children];
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
    
    CCArray *arr = [self children];
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
            //mynode.visible = NO;
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
    
    CCArray *arr = [self children];
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
                                                             position: ccp(curNode.position.x, startHeight)],
                                         [CCCallBlock actionWithBlock: ^(id sender) {curNode.isEnabled = NO;}], nil]];
                }
                if(curNode.tag == secondTag)
                {
                    [curNode runAction: [CCSequence actions:
                                         [CCMoveTo actionWithDuration: 0.2
                                                             position: ccp(curNode.position.x, startHeight)],
                                         [CCCallBlock actionWithBlock: ^(id sender) {curNode.isEnabled = NO;}], nil]];
                }
            }
            //mynode.visible = NO;
        }
    }
}

@end
