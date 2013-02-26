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
#import "Congratulations.h"


#import "AppDelegate.h"

#import "Animal.h"
#import "CCBReader.h"
#import "CCSpriteMoveAnimal.h"

#import "FinishGame.h"
#import "CartScene.h"

#import "MKStoreManager.h"

//#import "Chartboost.h"


@implementation GameLayer

@synthesize layer;

- (void) dealloc
{
    [super dealloc];
    [animalsArray release];
    [starsArray release];
    [bushesArray release];
    [numbersArray release];
}

-(void) didLoadFromCCB
{
    arr = [self children];
    
    [MKStoreManager sharedManager].delegate = self;
    
    [[SimpleAudioEngine sharedEngine] playBackgroundMusic: @"bg.mp3"];
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume: [Settings sharedSettings].soundLevel];
    
    animalsArray = [[NSMutableArray alloc] init];
    starsArray = [[NSMutableArray alloc] init];
    bushesArray = [[NSMutableArray alloc] init];
    numbersArray = [[NSMutableArray alloc] init];
    
    [self preloadTutorial];
    
    [self restartLevel];
    
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
    
    isGameActive = YES;
}

#pragma mark Tutorial

- (void) preloadTutorial
{
    tutorialSprite = [CCSprite spriteWithFile: @"tutorial.png"];
    tutorialSprite.position = ccp(GameCenterX, GameCenterY * 3);
    [self addChild: tutorialSprite z: 3];
    
    secondTutorialSprite = [CCSprite spriteWithFile: @"tutorial2.png"];
    secondTutorialSprite.position = ccp(GameCenterX * 3 - displaymentX / 2, GameCenterY * coefficientForTutorial);
    [tutorialSprite addChild: secondTutorialSprite];
    
    CCMenuItemImage *nextBtn = [CCMenuItemImage itemWithNormalImage: @"nextBtn.png"
                                                      selectedImage: @"nextBtnOn.png"
                                                             target: self
                                                           selector: @selector(showNextTutorialList)
                                ];
    
    CCMenuItemImage *exitBtn = [CCMenuItemImage itemWithNormalImage: @"ok.png"
                                                      selectedImage: @"okOn.png"
                                                             target: self
                                                           selector: @selector(hideTutorial)
                                ];
    
    CCMenuItemImage *animalsPackBtn = [CCMenuItemImage itemWithNormalImage: @"animalsShop.png"
                                                             selectedImage: @"animalsShop.png"
                                                                    target: self
                                                                  selector: @selector(goToShop)
                                       ];
    
    CCMenuItemImage *babyModeBtn = [CCMenuItemImage itemWithNormalImage: @"BMShop.png"
                                                          selectedImage: @"BMShop.png"
                                                                 target: self
                                                               selector: @selector(goToShop)
                                    ];
    
    CCMenuItemImage *speedOne = [CCMenuItemImage itemWithNormalImage: @"speed0.png"
                                                       selectedImage: @"speed0.png"
                                                              target: self
                                                            selector: @selector(setSpeed:)
                                 ];
    
    CCMenuItemImage *speedTwo = [CCMenuItemImage itemWithNormalImage: @"speed1.png"
                                                       selectedImage: @"speed1.png"
                                                              target: self
                                                            selector: @selector(setSpeed:)
                                 ];
    
    CCMenuItemImage *speedThree = [CCMenuItemImage itemWithNormalImage: @"speed2.png"
                                                         selectedImage: @"speed2.png"
                                                                target: self
                                                              selector: @selector(setSpeed:)
                                   ];
    
    nextBtn.position = posForNextTutorialBtn;
    exitBtn.position = posForExitTutorialBtn;
    
    speedOne.position = ccp(xPosS1 + displaymentX, GameCenterY * speedBtnHeightCoef);
    speedTwo.position = ccp(xPosS2 + displaymentX, GameCenterY * speedBtnHeightCoef);
    speedThree.position = ccp(xPosS3 + displaymentX, GameCenterY * speedBtnHeightCoef);
    
    speedOne.tag = 0;
    speedTwo.tag = 1;
    speedThree.tag = 2;
    
    speedOne.scale = speedBtnScale;
    speedTwo.scale = speedBtnScale;
    speedThree.scale = speedBtnScale;
    
    animalsPackBtn.position = ccp(xPosAnimBtn + displaymentX, GameCenterY * anBtnHeightCoef);
    babyModeBtn.position = ccp(xPosAnimBtn + displaymentX, GameCenterY * BMBtnHeightCoef);
    
    animalsPackBtn.scale = 0.66;
    babyModeBtn.scale = 0.66;
    
    CCMenu *tutorialMenu = [CCMenu menuWithItems: nextBtn, exitBtn, animalsPackBtn, babyModeBtn, speedOne, speedTwo, speedThree, nil];
    tutorialMenu.position = ccp(0, 0);
    [tutorialSprite addChild: tutorialMenu z:1 tag: 9999];
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
    
    [tutorialSprite runAction: [CCSequence actions:
                                [CCMoveTo actionWithDuration: 0.2 position: ccp(-GameCenterX, GameCenterY * 3)],
                                [CCMoveTo actionWithDuration: 0 position: ccp(GameCenterX, GameCenterY * 3)],
                                nil
                                ]
     ];
    
    for(CCMenu *curMenu in arr)
    {
        if(curMenu.tag == 666 || curMenu.tag == 222)
        {
            curMenu.isTouchEnabled = YES;
        }
    }
    
}

- (void) showNextTutorialList
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    [tutorialSprite runAction: [CCMoveTo actionWithDuration: 0.5 position: ccp(-GameCenterX, GameCenterY)]];
}

#pragma mark Play animations

- (void) playAnimationForBush: (NSInteger) tagOfAnimal
{
    
    NSString *animalTag = [NSString stringWithFormat: @"%i", tagOfAnimal];
    NSString *animalNumber = [animalTag substringFromIndex: 1];
    
    CCLOG(@"tagOfAnimal : %@", animalNumber);
    
    NSInteger tagForBush = [[NSString stringWithFormat: @"%i00%@", sceneNum, animalNumber] integerValue];
    
    [self playBushAnimation: tagForBush];
}

- (void) playBushAnimation: (NSInteger) bushNum
{
    for(CCSprite *curBush in arr)
    {
            if(curBush.tag == bushNum)
            {
                CCLOG(@"curBushTag : %i  BushNum: %i", curBush.tag, bushNum);
                
                [curBush runAction:
                                [CCAnimate actionWithAnimation:
                                                    [[CCAnimationCache sharedAnimationCache] animationByName: [NSString stringWithFormat: @"scene_%i_bush_%i_", sceneNum, (bushNum - 1000 * sceneNum)]]
                                 ]
                 ];
            }
    }
}

#pragma mark Settings

- (void) setSpeed: (CCMenuItemImage *) sender
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    [Settings sharedSettings].gameMode = sender.tag;
    [[Settings sharedSettings] save];
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

#pragma mark Game process



- (void) restartLevel
{
    NSArray *coordinatsItems = [subZeroCoordinats componentsSeparatedByString: @"/"];
    
    coordinats = [NSString stringWithFormat: @""];
    
    for(CCSprite *curSprite in animalsArray)
    {
        [curSprite stopAllActions];
    }
    
    for (CCSprite *curBush in bushesArray)
    {
        [curBush stopAllActions];
    }
    
    [self stopAllActions];
    
    for(int i = 0; i < [animalsArray count]; i++)
    {
        NSInteger posX = [[coordinatsItems objectAtIndex: 2 * i + 0] integerValue];
        NSInteger posY = [[coordinatsItems objectAtIndex: 2 * i + 1] integerValue];
        
        [[animalsArray objectAtIndex: i] setPosition: ccp(posX, posY)];
    }
    
    [bushesArray removeAllObjects];
    [animalsArray removeAllObjects];
    
    time = 30;
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: [NSString stringWithFormat: @"alarm.plist"]];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: [NSString stringWithFormat: @"numbers.plist"]];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: [NSString stringWithFormat: @"animalsAnimation.plist"]];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile: [NSString stringWithFormat: @"scene_%i_bushes.plist", sceneNum]];
    
    for (int i = 1; i < 7; i++)
    {
        [Common loadAnimationWithPlist: @"Animations" andName: [NSString stringWithFormat: @"animal_%i_pos_%i_film_", animalNum, i]];
    }
    
    [Common loadAnimationWithPlist: @"Animations" andName: @"clock_"];
    
    countOfBushes = 0;
    
    for(CCSprite *curBush in arr)
    {
        if(curBush.tag > (sceneNum * 1000))
        {
            
            countOfBushes++;
        }
    }
    
    for (int i = 1; i <= countOfBushes; i++)
    {
        [Common loadAnimationWithPlist: @"bushesAnimations" andName: [NSString stringWithFormat: @"scene_%i_bush_%i_", sceneNum, i]];
    }
    
    for(CCSprite *curSpr in arr)
    {
        
        for (int i = 1; i < 7; i++)
        {
            NSString *curNum = [NSString stringWithFormat: @"%i%i", animalNum, i];
            
            NSInteger curTag = [curNum integerValue];
            
            if(curSpr.tag == curTag)
            {
                curSpr.gameLayer = self;
                
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
    
    
    if([Settings sharedSettings].enabledBabyMode == 0)
    {
        [self schedule: @selector(timer) interval: 1];
    }
    
    if([Settings sharedSettings].enabledBabyMode == 1)
    {
        for(CCMenu *curMenu in arr)
        {
            if(curMenu.tag == 66)
            {
                CCArray *menuArr = [curMenu children];
                
                for(CCMenuItemImage *curItem in menuArr)
                {
                    if(curItem.tag == 660)
                    {
                        curItem.isEnabled = NO;
                        curItem.visible = NO;
                        
                        CCMenuItemImage *goToMainMenu = [CCMenuItemImage itemWithNormalImage: @"homeBtn.png"
                                                                               selectedImage: @"homeBtnOn.png"
                                                                                      target: self
                                                                                    selector: @selector(showMainMenu)
                                                         ];
                        
                        CCMenu *mainMenu = [CCMenu menuWithItems: goToMainMenu, nil];
                        mainMenu.position = curItem.position;
                        [self addChild: mainMenu];
                    }
                }
            }
        }
    }
    
    [coordinats retain];
    [coordinatsItems retain];
    
}

- (void) restart
{
    [self resumeSchedulerAndActions];
    
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    [self runAction: [CCSequence actions:
                      [CCCallBlock actionWithBlock: ^(id sender){[self unPause];}],
                      [CCCallBlock actionWithBlock: ^(id sender){[self removeStars];}],
                      [CCCallBlock actionWithBlock: ^(id sender){[self restartLevel];}],
                      nil]
     ];
}

- (void) pause
{
    isGameActive = NO;
    
    //[[Chartboost sharedChartboost] showInterstitial];
    
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
    
    for (CCSprite *curBush in bushesArray)
    {
        [curBush pauseSchedulerAndActions];
    }
    
    [self pauseSchedulerAndActions];
}

- (void) unPause
{
    isGameActive = YES;
    
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
    
    for (CCSprite *curBush in bushesArray)
    {
        [curBush resumeSchedulerAndActions];
    }
    
    [self resumeSchedulerAndActions];
}

#pragma mark Touches

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
            curNode.isCanTap = NO;
            [curNode stopAllActions];
            
            //if([Settings sharedSettings].enabledBabyMode == 0)
            //{
                
                [curNode runAction: [CCSequence actions:
                                     [CCJumpTo actionWithDuration: 1
                                                         position: animalFlyPoint
                                                           height: 50
                                                            jumps: 1],
                                     [CCCallBlock actionWithBlock: ^(id sender)
                                      {
                                          if([starsArray count] >= 6)
                                          {
                                              if([Settings sharedSettings].enabledBabyMode == 0)
                                              {
                                                  [self showMotherScene];
                                              }
                                              else
                                              {
                                                  sceneNum++;
                                                  
                                                  if(sceneNum > 3)
                                                  {
                                                      sceneNum = 1;
                                                      
                                                      if([MKStoreManager featureAPurchased])
                                                      {
                                                          animalNum++;
                                                          
                                                          if(animalNum > 3)
                                                          {
                                                              animalNum = 1;
                                                          }
                                                      }
                                                  }
                                                  
                                                  CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"gameScene_%i%@.ccbi", sceneNum, postFix]];
                                                  
                                                  [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 0.5 scene: mainScene]];
                                              }
                                          }
                                      }],
                                     nil]
                 ];
            
            
                [self addStar];
            
            //}
            
           // if ([Settings sharedSettings].enabledBabyMode == 1)
           // {
           //     [[SimpleAudioEngine sharedEngine] playEffect: [NSString stringWithFormat: @"%ianimal.mp3", animalNum]];
                
            //    [curNode hideAnimal];
           // }
        }
    }
    
    return YES;
}

#pragma mark Navigation

- (void) goToShop
{
    [[SimpleAudioEngine sharedEngine] playEffect: @"btn.caf"];
    
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1.0 scene: [CartScene scene]]];
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

#pragma mark Other

- (void) timer
{
    if(time > 0)
    {
        time--;
    }
    
    if(time >= 0 && time <= 10)
    {
        [[SimpleAudioEngine sharedEngine] playEffect: @"clock.wav"];
        
        for(CCNode *xNode in arr)
        {
            if(xNode.tag == 99)
            {
                CCSprite *timeSpr = [CCSprite spriteWithSpriteFrameName: [NSString stringWithFormat: @"num%i.png", time]];
                timeSpr.position = ccp(GameCenterX * 0.2, GameCenterY * 1.8);
                [xNode addChild: timeSpr];
                
                [numbersArray addObject: timeSpr];
            }
        }
        
        if(time <= 0)
        {
            
            [[SimpleAudioEngine sharedEngine] playEffect: @"alarm.mp3"];
            
            for(CCSprite *curNode in animalsArray)
            {
                [curNode pauseSchedulerAndActions];
            }
            
            for (CCSprite *curBush in bushesArray)
            {
                [curBush pauseSchedulerAndActions];
            }
            
            [self pauseSchedulerAndActions];
            
            self.isTouchEnabled = NO;
            
            
            CCSprite *centerSprite = [CCSprite spriteWithFile: @"hiddenSprite.png"];
            centerSprite.position = ccp(GameCenterX, GameCenterY);
            [self addChild: centerSprite];
            
            CCLOG(@"OJ");
            
            [centerSprite runAction:
             [CCAnimate actionWithAnimation:
              [[CCAnimationCache sharedAnimationCache] animationByName: @"clock_"]
              ]
             
             ];
            [self runAction: [CCSequence actions:
                              [CCDelayTime actionWithDuration: 1.8],
                              
                              [CCCallBlock actionWithBlock: ^(id sender)
                               {
                                   [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: [Congratulations sceneWithStars:[starsArray count]]]];
                               }],
                              nil]
             ];
        }
    }
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
            
            /*if([Settings sharedSettings].enabledBabyMode == 1)
            {
                starSprite.visible = NO;
            }*/
            
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
            
            for(CCSprite *numToRemove in numbersArray)
            {
                [xNode removeChild: numToRemove cleanup: YES];
            }
        }
    }
    
    [starsArray removeAllObjects];
    [numbersArray removeAllObjects];
}

@end
