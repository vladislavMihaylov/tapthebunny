//
//  CartScene.h
//  taptapper
//
//  Created by Vlad on 04.02.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CartScene: CCLayer
{
    CCSprite *animalsPackBuyed;
    CCSprite *babyModeBuyed;
    
    CCMenu *animalsMenu;
    CCMenu *babyModeMenu;
    CCMenu *backMenu;
    CCMenu *restoreMenu;
}

- (void) unlockMenu;
+ (CCScene *) scene;

@end
