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
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) sceneWithAnimal: (NSInteger) numOfAnimal;

@end
