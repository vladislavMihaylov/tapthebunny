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
#import "Settings.h"
#import "SimpleAudioEngine.h"

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
    arr = [self children];
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic: @"bg.mp3"];
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: [Settings sharedSettings].soundLevel];
    
    animalsArray = [[NSMutableArray alloc] init];
    starsArray = [[NSMutableArray alloc] init];
    
    tutorialSprite = [CCSprite spriteWithFile: @"tutorial.png"];
    tutorialSprite.position = ccp(GameCenterX, GameCenterY * 3);
    [self addChild: tutorialSprite z: 3];
        
    [self restartLevel];
    
    CCMenuItemImage *okBtn = [CCMenuItemImage itemWithNormalImage: @"ok.png"
                                                    selectedImage: @"okOn.png"
                                                           target: self
                                                         selector: @selector(hideTutorial)
                              ];
    
    okBtn.position = posForOkBtn;
    
    CCMenu *tutorialMenu = [CCMenu menuWithItems: okBtn, nil];
    tutorialMenu.position = ccp(0, 0);
    [tutorialSprite addChild: tutorialMenu z:1 tag: 9999];
    
    subZeroCoordinats = coordinats;

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: [NSString stringWithFormat: @"pauseMenu.plist"]];
    
    CCSprite *soundOnBtn = [CCSprite spriteWithSpriteFrameName: @"soundOnBtn.png"];
    CCSprite *soundOffBtn = [CCSprite spriteWithSpriteFrameName: @"soundOffBtn.png"];
    CCSprite *select = [CCSprite spriteWithFile: @"icon.png"];
    
    CCMenuItemImage *on = [CCMenuItemImage itemWithNormalSprite: soundOnBtn selectedSprite: select];
    CCMenuItemImage *off = [CCMenuItemImage itemWithNormalSprite: soundOffBtn selectedSprite: select];
    
    CCMenu *soundMenu = [CCMenu menuWithItems: nil];
    soundMenu.position = ccp(0, 0);
    [self addChild: soundMenu z:1 tag: 222];
    
    if ([Settings sharedSettings].soundLevel == 0)
    {
        CCMenuItemToggle *sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundMode) items: off, on, nil];
        sound.position = posForSoundBtnInGameMenuHide;
        [soundMenu addChild: sound z: 1 tag: kSoundBtnTag];
    }
    else if ([Settings sharedSettings].soundLevel == 1)
    {
        CCMenuItemToggle *sound = [CCMenuItemToggle itemWithTarget:self selector:@selector(soundMode) items: on, off, nil];
        sound.position = posForSoundBtnInGameMenuHide;
        [soundMenu addChild: sound z: 1 tag: kSoundBtnTag];
    }
    
    

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
- (void) showTutorial
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    [tutorialSprite runAction: [CCMoveTo actionWithDuration: 0.3 position: ccp(GameCenterX, GameCenterY)]];

    for(CCMenu *curMenu in arr)
    {
        if(curMenu.tag == 666 || curMenu.tag == 222)
        {
            curMenu.isTouchEnabled = NO;
        }
    }
    
}

- (void) hideTutorial
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    [tutorialSprite runAction: [CCMoveTo actionWithDuration: 0.2 position: ccp(GameCenterX, GameCenterY * 3)]];
    
    for(CCMenu *curMenu in arr)
    {
        if(curMenu.tag == 666 || curMenu.tag == 222)
        {
            curMenu.isTouchEnabled = YES;
        }
    }

}

- (void) soundMode
{
    if ([Settings sharedSettings].soundLevel == 1)
    {
        [Settings sharedSettings].soundLevel = 0;
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: 0];
        [[SimpleAudioEngine sharedEngine] setEffectsVolume: 0];
    }
    else
    {
        [Settings sharedSettings].soundLevel = 1;
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: 1];
        [[SimpleAudioEngine sharedEngine] setEffectsVolume: 1];
    }
    
    [[Settings sharedSettings] save];
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
            
            [curNode runAction: [CCSequence actions:
                                        [CCJumpTo actionWithDuration: 1 position: animalFlyPoint height: 50 jumps: 1],
                                 [CCCallBlock actionWithBlock: ^(id sender){
                
                                 if([starsArray count] >= 6)
                                 {
                                     [self showMotherScene];
                                 }
                                 }],
                                 nil]
            ];
            
            
            
            [self addStar];
        }
    }
    
    return YES;
}

- (void) restart
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    [self runAction: [CCSequence actions:
                                    [CCCallBlock actionWithBlock: ^(id sender){[self unPause];}],
                                    [CCCallBlock actionWithBlock: ^(id sender){[self restartLevel];}],
                                    [CCCallBlock actionWithBlock: ^(id sender){[self removeStars];}],
                      nil]
     ];
}

- (void) pause
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    self.isTouchEnabled = NO;
    
    for(CCLayerColor *curLayerColor in arr)
    {
        if(curLayerColor.tag == 777)
        {
            
            curLayerColor.visible = YES;
        }
    }
    
    for(CCMenu *curMenu in arr)
    {
        if(curMenu.tag == 222)
        {
            CCArray *menuArr = [curMenu children];
            
            for(CCNode *curNode in menuArr)
            {
                [curNode runAction: [CCMoveTo actionWithDuration: 0.3 position: posForSoundBtnInGameMenu]];
            }
        }
    }
    
    for(CCMenu *curMenu in arr)
    {
        if(curMenu.tag == 666)
        {
            [curMenu runAction: [CCMoveTo actionWithDuration: 0.3 position: posForOpenMenu]];
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
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    self.isTouchEnabled = YES;
    
    for(CCLayerColor *curLayerColor in arr)
    {
        if(curLayerColor.tag == 777)
        {
            curLayerColor.visible = NO;
        }
    }
    
    for(CCMenu *curMenu in arr)
    {
        if(curMenu.tag == 222)
        {
            CCArray *menuArr = [curMenu children];
            
            for(CCNode *curNode in menuArr)
            {
                [curNode runAction: [CCMoveTo actionWithDuration: 0.1 position: posForSoundBtnInGameMenuHide]];
            }
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
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"MainMenuScene%@.ccbi", postFix]];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
}

- (void) showSelectMenu
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    CCScene* selectAnimalScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"SelectAnimal%@.ccbi", postFix]];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: selectAnimalScene]];
}

- (void) showMotherScene
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: [FinishGame scene]]];
}

- (void) addStar
{
    [[SimpleAudioEngine sharedEngine] playEffect: [NSString stringWithFormat: @"%ianimal.mp3", animalNum]];
    
    // Далее немного магии. Если добавлять спрайт звезды напрямую в селф, то у LayerColor выставляется неправильный z-индекс
    // и он оказывается "ближе" к экрану, чем меню. У нода с тэгом 99 в билдере z-индекс меньше, чем у меню, поэтому все равботает ок.
    
    for(CCNode *xNode in arr)
    {
        if(xNode.tag == 99)
        {
            CCSprite *starSprite = [CCSprite spriteWithFile: @"star.png"];
            
            starSprite.position = ccp(widthForStar + stepOfStar * [starsArray count], heightForStar);
            
            [xNode addChild: starSprite];
            
            [starsArray addObject: starSprite];
        }
    }
}

- (void) removeStars
{
    for(CCNode *xNode in arr)
    {
        if(xNode.tag == 99)
        {
            for(CCSprite *spriteToRemove in starsArray)
            {
                [xNode removeChild: spriteToRemove cleanup: YES];
            }
        }
    }
    
    [starsArray removeAllObjects];
}

@end
