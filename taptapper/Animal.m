//
//  Animal.m
//  taptapper
//
//  Created by Vlad on 28.01.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Animal.h"
#import "Common.h"

@implementation Animal

+ (Animal *) createWithAnimalNum: (NSInteger) animalNum andPos: (NSInteger) posNum
{
    Animal *animal = [[[Animal alloc] initWithAnimalNum: animalNum andPos: posNum] autorelease];
    
    return animal;
}

- (void) dealloc
{
    [super dealloc];
}

- (id) initWithAnimalNum: (NSInteger) animalNum andPos: (NSInteger) posNum
{
    if(self  = [super init])
    {
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: [NSString stringWithFormat: @"animalsAnimation.plist"]];
        
        item = [CCSprite spriteWithSpriteFrameName: [NSString stringWithFormat: @"animal_%i_pos_%i_film_1.png", animalNum, posNum]];
        [self addChild: item];
        
        [Common loadAnimationWithPlist: @"Animations" andName: [NSString stringWithFormat: @"animal_%i_pos_%i_film_", animalNum, posNum]];
        
        [item runAction:
            [CCRepeatForever actionWithAction:
                                [CCAnimate actionWithAnimation:
                                        [[CCAnimationCache sharedAnimationCache] animationByName: [NSString stringWithFormat: @"animal_%i_pos_%i_film_", animalNum, posNum]]
                                 ]
             ]
     ];
        
        [self registerWithTouchDispatcher];

    }
    
    return self;
}


- (BOOL) isTapped: (CGPoint) location
{
    CCLOG(@"X: %f Y: %f", self.position.x, self.position.y);
    
    float Ax = item.contentSize.width / 2;
    float Ay = item.contentSize.height / 2;
    float Tx = fabs(self.position.x - location.x);
    float Ty = fabsf(self.position.y - location.y);
    
    BOOL result = Tx <= Ax && Ty <= Ay;
    
    return result;
}

@end
