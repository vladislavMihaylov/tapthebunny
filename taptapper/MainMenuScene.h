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
    
    CCMenuItemImage *buyBaby;
    CCMenuItemImage *monster;
    CCMenuItemImage *baby;
    
    CCMenu *speedMenu;
    CCMenu *buyBabyMenu;
    
}

@end
