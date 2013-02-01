
#import <Foundation/Foundation.h>

@interface Settings: NSObject
{
    NSInteger soundLevel;
    NSInteger gameMode;
}

+ (Settings *) sharedSettings;

- (void) load;
- (void) save;

@property (nonatomic, assign) NSInteger soundLevel;
@property (nonatomic, assign) NSInteger gameMode;

@end