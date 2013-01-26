//
//  Map.m
//  old48Game
//
//  Created by Vlad on 15.12.12.
//  Copyright 2012 spotGames. All rights reserved.
//

#import "Map.h"
#import "CCBReader.h"
#import "GameConfig.h"

#import "GameLayer.h"

@implementation Map


/*- (void) didLoadFromCCB
{
    CCArray *arr = [self children];
    for(CCNode *mynode in arr)
    {
        if(mynode.tag == kParentTag)
        {
            CCArray *arr2Menu = [mynode children];
            for(CCNode *menuNode in arr2Menu)
            {
                if(menuNode.tag = kMenuNodeTag)
                {
                    CCArray *nodeChildrensArr = [menuNode children];
                    
                    for(CCMenu *node in nodeChildrensArr)
                    {
                        if(node.tag == kFirstMenuTag)
                        {
                            CCLOG(@"first");
                            
                            [firstMenuElementsArray addObject: node];
                        }
                        if(node.tag == kSecondMenuTag)
                        {
                            CCLOG(@"second");
                        }
                    }
                    
                    
                    
                }
            }
        }
    }

    CCLOG(@"ololo %@", firstMenuElementsArray);
}*/

/*- (void) checkAvaiability
{
    for(int i = 0; i < countOfOpenedLevels; i++)
    {
        //CCMenuItemImage *curElement = [elementsArray objectAtIndex: i];
        //curElement.visible = YES;
        //CCLOG(@"menuElement tag %i", curElement.tag);
    }
}*/

/*if(sender.tag % kMultiplier == 0)
 {
 if(countOfBrilliant < (sender.tag - kMultiplier) * kMultiplier)
 {
 CCLOG(@"No!");
 }
 else
 {
 CCLOG(@"curLevel: %i", sender.tag);
 }
 }
 else
 {
 CCLOG(@"curLevel: %i", sender.tag);
 }*/

- (void) pressedPlay: (CCMenuItemImage *) sender
{
    // сюда вставить код для запуска игры
    [[CCDirector sharedDirector] replaceScene: [GameLayer sceneWithLevelIndex: 0]];
}


@end
