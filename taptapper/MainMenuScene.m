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


@implementation MainMenuScene

- (void) pressedPlay: (id) sender
{
    CCScene* selectAnimalScene = [CCBReader sceneWithNodeGraphFromFile: @"SelectAnimalScene.ccbi"];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: selectAnimalScene]];
}

- (void) pressedShare
{
    [self hideSubButtonsWithTag: kSpeedBtnTag andSecondTag: kSoundBtnTag];
    
    if(!isOpenShareMenu)
    {
        [self showSubButtonsWithTag: kFaceBookBtnTag andSecondTag: kTwitterBtnTag];
    }
    else
    {
        [self hideSubButtonsWithTag: kFaceBookBtnTag andSecondTag: kTwitterBtnTag];
    }
}

- (void) pressedOptions: (id) sender
{
    [self hideSubButtonsWithTag: kFaceBookBtnTag andSecondTag: kTwitterBtnTag];
    
    if(!isOpenOptionsMenu)
    {
        [self showSubButtonsWithTag: kSpeedBtnTag andSecondTag: kSoundBtnTag];
    }
    else
    {
        [self hideSubButtonsWithTag: kSpeedBtnTag andSecondTag: kSoundBtnTag];
    }
}

- (void) pressedCart: (id) sender
{
    [self hideSubButtonsWithTag: kFaceBookBtnTag andSecondTag: kTwitterBtnTag];
    [self hideSubButtonsWithTag: kSpeedBtnTag andSecondTag: kSoundBtnTag];
    
    CCLOG(@"Cart");
}

- (void) pressedGift: (id) sender
{
    [self hideSubButtonsWithTag: kFaceBookBtnTag andSecondTag: kTwitterBtnTag];
    [self hideSubButtonsWithTag: kSpeedBtnTag andSecondTag: kSoundBtnTag];
    
    CCLOG(@"Gift");
}

- (void) sendFB
{
    CCLOG(@"FaceBook");
}

- (void) sendTweet
{
    CCLOG(@"Twitter");
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
    
    CCLOG(@"OKAY");
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
                                                                            position: ccp(curNode.position.x, 100)],
                                         [CCCallBlock actionWithBlock: ^(id sender) {curNode.isEnabled = YES;}], nil]];
                }
                if(curNode.tag == secondTag)
                {
                    [curNode runAction: [CCSequence actions:
                                         [CCMoveTo actionWithDuration: 0.2
                                                             position: ccp(curNode.position.x, 150)],
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
                                                             position: ccp(curNode.position.x, 50)],
                                         [CCCallBlock actionWithBlock: ^(id sender) {curNode.isEnabled = NO;}], nil]];
                }
                if(curNode.tag == secondTag)
                {
                    [curNode runAction: [CCSequence actions:
                                         [CCMoveTo actionWithDuration: 0.2
                                                             position: ccp(curNode.position.x, 50)],
                                         [CCCallBlock actionWithBlock: ^(id sender) {curNode.isEnabled = NO;}], nil]];
                }
            }
            //mynode.visible = NO;
        }
    }
}

@end
