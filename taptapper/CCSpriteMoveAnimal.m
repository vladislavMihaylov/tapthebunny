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
                                    [CCDelayTime actionWithDuration: 0.5],
                                    [CCCallBlock actionWithBlock: ^(id sender) {[self moveAnimal];} ],
                      nil]
     ];
}

- (void) moveAction
{
    [self runAction: [CCSequence actions:
                                    [CCMoveTo actionWithDuration: 0.3
                                                        position: ccp(self.position.x, self.position.y + 50)],
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