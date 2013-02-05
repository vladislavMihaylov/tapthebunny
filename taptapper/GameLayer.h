//
//  HelloWorldLayer.h
//  taptapper
//
//  Created by Vlad on 25.01.13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

@interface GameLayer : CCLayer
{
    NSInteger screenWidth;
    NSInteger screenHeight;
    
    NSMutableArray *animalsArray;
    NSMutableArray *starsArray;
    NSMutableArray *bushesArray;
    
    NSString *coordinats;
    NSString *subZeroCoordinats;
    
    CCSprite *tutorialSprite;
    
    CCArray *arr;
}

- (void) restartLevel;
- (void) pause;
- (void) unPause;
- (void) showMotherScene;


@end
