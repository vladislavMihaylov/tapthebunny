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
#import "GuiLayer.h"

@interface GameLayer : CCLayer
{
    GuiLayer *gui;
    
    NSInteger screenWidth;
    NSInteger screenHeight;
}

+(CCScene *) sceneWithAnimal: (NSInteger) numOfAnimal;

@property (nonatomic, assign) GuiLayer *guiLayer;

@end
