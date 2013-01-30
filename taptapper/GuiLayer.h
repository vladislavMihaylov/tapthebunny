//
//  GuiLayer.h
//  taptapper
//
//  Created by Vlad on 27.01.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameLayer;

@interface GuiLayer: CCLayer
{
    GameLayer *gameLayer;
    
    CCSpriteBatchNode *batchNode;
    
    CCSprite *boxSprite;
    
    CCSprite *pauseBtn;
    CCSprite *pauseBtnOn;
    
    CCSprite *hideMenuBtn;
    CCSprite *hideMenuBtnOn;
    
    CCSprite *restartBtn;
    CCSprite *restartBtnOn;
    
    CCSprite *homeBtn;
    CCSprite *homeBtnOn;
    
    CCSprite *selectBtn;
    CCSprite *selectBtnOn;
    
    CCSprite *soundBtnOn;
    CCSprite *soundBtnOff;
    
    CCSprite *tutorialBtn;
    CCSprite *tutorialBtnOn;
    
    CCSprite *other;
    CCSprite *other2;
    
    NSInteger screenWidth;
    NSInteger screenHeight;
    
    NSMutableArray *starsArray;
}

- (void) addStar;

@property (nonatomic, assign) GameLayer *gameLayer;

@end
