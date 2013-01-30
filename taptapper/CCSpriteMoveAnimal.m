#import "CCSpriteMoveAnimal.h"
#import "cocos2d.h"

@implementation CCSprite (CCSpriteMoveAnimal)

- (void) moveAnimal
{
    NSInteger randomNum;
    
    randomNum = arc4random() % 10;
    
    if(randomNum == 5)
    {
        [self moveAction];
    }
    else
    {
        [self wait];
    }
}

- (void) wait
{
    [self runAction: [CCSequence actions:
                                    [CCDelayTime actionWithDuration: 0.3],
                                    [CCCallBlock actionWithBlock: ^(id sender) {[self moveAnimal];} ],
                      nil]
     ];
}

- (void) moveAction
{
    NSInteger height;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        height = 120;
    }
    else
    {
        height = 50;
    }
    
    [self runAction: [CCSequence actions:
                                    [CCMoveTo actionWithDuration: 0.3
                                                        position: ccp(self.position.x, self.position.y + height)],
                                    [CCCallBlock actionWithBlock: ^(id sender) {self.isCanTap = YES;} ],
                                    [CCDelayTime actionWithDuration: 1],
                                    [CCCallBlock actionWithBlock: ^(id sender) {self.isCanTap = NO;} ],
                                    [CCMoveTo actionWithDuration: 0.3
                                                        position: ccp(self.position.x, self.position.y)],
                                    [CCCallBlock actionWithBlock: ^(id sender) {[self moveAnimal];} ],
                      nil]
     ];
}

- (void) pauseActions
{
    [self pauseSchedulerAndActions];
}

@end