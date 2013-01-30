//
//  HelloWorldLayer.m
//  taptapper
//
//  Created by Vlad on 25.01.13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "GameLayer.h"
#import "GameConfig.h"
#import "Common.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "Animal.h"
#import "CCBReader.h"
#import "CCSpriteMoveAnimal.h"

#import "FinishGame.h"

// HelloWorldLayer implementation
@implementation GameLayer


-(void) didLoadFromCCB
{
    animalsArray = [[NSMutableArray alloc] init];
    starsArray = [[NSMutableArray alloc] init];
        
    [self restartLevel];
    
    subZeroCoordinats = coordinats;

    CCLOG(@"In init %i", [animalsArray count]);
}

- (void) restartLevel
{
    NSArray *coordinatsItems = [subZeroCoordinats componentsSeparatedByString: @"/"];
    CCLOG(@"Coordinats %@", subZeroCoordinats);
    
    coordinats = [NSString stringWithFormat: @""];
    
    for(CCSprite *curSprite in animalsArray)
    {
        [curSprite stopAllActions];
    }
    
    for(int i = 0; i < [animalsArray count]; i++)
    {
        NSInteger posX = [[coordinatsItems objectAtIndex: 2 * i + 0] integerValue];
        NSInteger posY = [[coordinatsItems objectAtIndex: 2 * i + 1] integerValue];
        
        [[animalsArray objectAtIndex: i] setPosition: ccp(posX, posY)];
    }
    
    [animalsArray removeAllObjects];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: [NSString stringWithFormat: @"animalsAnimation.plist"]];
    
    
    for (int i = 1; i < 7; i++)
    {
        [Common loadAnimationWithPlist: @"Animations" andName: [NSString stringWithFormat: @"animal_%i_pos_%i_film_", animalNum, i]];
    }
    
    
    CCArray *arr = [self children];
    for(CCSprite *curSpr in arr)
    {
        for (int i = 1; i < 7; i++)
        {
            NSString *curNum = [NSString stringWithFormat: @"%i%i", animalNum, i];
            
            NSInteger curTag = [curNum integerValue];
            
            if(curSpr.tag == curTag)
            {
                [curSpr runAction:
                            [CCRepeatForever actionWithAction:
                                                [CCAnimate actionWithAnimation:
        [[CCAnimationCache sharedAnimationCache] animationByName: [NSString stringWithFormat: @"animal_%i_pos_%i_film_", animalNum, i]]
                                                 ]
                             ]
                 ];
                
                NSString *curItemCoord = [NSString stringWithFormat: @"%f/%f/", curSpr.position.x, curSpr.position.y];
                
                coordinats = [coordinats stringByAppendingString: curItemCoord];
                
                curSpr.isCanTap = NO;
                [curSpr moveAnimal];
                
                [animalsArray addObject: curSpr];
            }
        }
    }
    
    [coordinats retain];
    [coordinatsItems retain];
    
}

- (void) registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate: self priority: 0 swallowsTouches: YES];
}

- (BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL: location];

    
    for(CCSprite *curNode in animalsArray)
    {
        float Ax = fabsf(location.x - curNode.position.x);
        float Ay = fabsf(location.y - curNode.position.y);
        
        if((Ax <= curNode.contentSize.width / 2) && (Ay <= curNode.contentSize.height / 2) && curNode.isCanTap == YES)
        {
            CCLOG(@"TAAP");
            curNode.isCanTap = NO;
            [curNode stopAllActions];
            
            [curNode runAction: [CCSpawn actions:
                                        [CCJumpTo actionWithDuration: 1 position: animalFlyPoint height: 50 jumps: 1],
                                nil]
                ];
            
            [self addStar];
        }
    }
    
    return YES;
}

- (void) restart
{
    [self runAction: [CCSequence actions:
                                    [CCCallBlock actionWithBlock: ^(id sender){[self unPause];}],
                                    [CCCallBlock actionWithBlock: ^(id sender){[self restartLevel];}],
                                    [CCCallBlock actionWithBlock: ^(id sender){[self removeStars];}],
                      nil]
     ];
}

- (void) pause
{
    self.isTouchEnabled = NO;
    
    CCArray *arr = [self children];
    
    for(CCLayerColor *curLayerColor in arr)
    {
        if(curLayerColor.tag == 777)
        {
            curLayerColor.visible = YES;
        }
    }
    
    for(CCMenu *curMenu in arr)
    {
        if(curMenu.tag == 666)
        {
            [curMenu runAction: [CCMoveTo actionWithDuration: 0.3 position: ccp(0, 0)]];
        }
        
        if(curMenu.tag == 66)
        {
            CCArray *menuArr = [curMenu children];
            
            for(CCMenuItemImage *curItem in menuArr)
            {
                if(curItem.tag == 660)
                {
                    curItem.isEnabled = NO;
                }
            }
        }
    }
    
    for(CCSprite *boxSprite in arr)
    {
        if(boxSprite.tag == 661)
        {
            [boxSprite runAction: [CCMoveTo actionWithDuration: 0.3 position: posForBoxSprite]];
        }
    }
    
    for(CCSprite *curNode in animalsArray)
    {
        [curNode pauseSchedulerAndActions];
    }
}

- (void) unPause
{
    self.isTouchEnabled = YES;
    
    CCArray *arr = [self children];
    
    for(CCLayerColor *curLayerColor in arr)
    {
        if(curLayerColor.tag == 777)
        {
            curLayerColor.visible = NO;
        }
    }
    
    for(CCMenu *curMenu in arr)
    {
        if(curMenu.tag == 666)
        {
            [curMenu runAction: [CCMoveTo actionWithDuration: 0.1 position: posForMenu]];
        }
        
        if(curMenu.tag == 66)
        {
            CCArray *menuArr = [curMenu children];
            
            for(CCMenuItemImage *curItem in menuArr)
            {
                if(curItem.tag == 660)
                {
                    curItem.isEnabled = YES;
                }
            }
        }
    }
    
    for(CCSprite *boxSprite in arr)
    {
        if(boxSprite.tag == 661)
        {
            [boxSprite runAction: [CCMoveTo actionWithDuration: 0.1 position: posForBoxSpriteHide]];
        }
    }
    
    for(CCSprite *curNode in animalsArray)
    {
        [curNode resumeSchedulerAndActions];
    }
}

- (void) showMainMenu
{
    CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"MainMenuScene%@.ccbi", postFix]];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
}

- (void) showSelectMenu
{
    CCScene* selectAnimalScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"SelectAnimal%@.ccbi", postFix]];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: selectAnimalScene]];
}

- (void) showMotherScene
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: [FinishGame scene]]];
}

- (void) addStar
{
    CCSprite *starSprite = [CCSprite spriteWithFile: @"star.png"];
    
    starSprite.position = ccp(widthForStar + stepOfStar * [starsArray count], heightForStar);
    
    [self addChild: starSprite];
    
    [starsArray addObject: starSprite];
    
    if([starsArray count] >= 6)
    {
        
        [self showMotherScene];
    }
}

- (void) removeStars
{
    for(CCSprite *spriteToRemove in starsArray)
    {
        [self removeChild: spriteToRemove cleanup: YES];
    }
    
    [starsArray removeAllObjects];
}

@end
