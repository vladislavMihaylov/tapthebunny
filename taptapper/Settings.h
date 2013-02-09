
#import <Foundation/Foundation.h>

@interface Settings: NSObject
{
    NSInteger soundLevel;
    NSInteger gameMode;
    NSInteger openAnimals;
    NSInteger openBabyMode;
}

+ (Settings *) sharedSettings;

- (void) load;
- (void) save;

@property (nonatomic, assign) NSInteger soundLevel;
@property (nonatomic, assign) NSInteger gameMode;
@property (nonatomic, assign) NSInteger openAnimals;
@property (nonatomic, assign) NSInteger openBabyMode;

@end