//
//  SelectAnimalScene.m
//  taptapper
//
//  Created by Vlad on 26.01.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SelectAnimalScene.h"
#import "CCBReader.h"

#import "GameLayer.h"

@implementation SelectAnimalScene

- (void) back
{
    CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: @"MainMenuScene.ccbi"];
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: mainScene]];
}

- (void) playWith: (CCMenuItemImage *) sender
{
    [[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration: 1 scene: [GameLayer sceneWithAnimal: sender.tag]]];
}

@end
