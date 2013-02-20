//
//  MainMenuScene.h
//  doodleCalls
//
//  Created by Vlad on 04.12.12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MainMenuScene: CCLayer
{
    BOOL isOpenShareMenu;
    BOOL isOpenOptionsMenu;
    
    CCArray *arr;
    
    NSMutableArray *optionBtnsArray;
    
    CCMenuItemToggle *sound;
    CCMenuItemToggle *speed;
    CCMenuItemToggle *babyMode;
}

@end
