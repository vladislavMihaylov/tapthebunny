//
//  Animal.h
//  taptapper
//
//  Created by Vlad on 28.01.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Animal: CCLayer
{
    CCSprite *item;
}

+ (Animal *) createWithAnimalNum: (NSInteger) animalNum andPos: (NSInteger) posNum;

- (BOOL) isTapped: (CGPoint) location;

@end
