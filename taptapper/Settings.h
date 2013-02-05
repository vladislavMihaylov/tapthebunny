
#import <Foundation/Foundation.h>

@interface Settings: NSObject
{
    NSInteger soundLevel;
    NSInteger gameMode;
    NSInteger openOwl;
    NSInteger openSquirrel;
}

+ (Settings *) sharedSettings;

- (void) load;
- (void) save;

@property (nonatomic, assign) NSInteger soundLevel;
@property (nonatomic, assign) NSInteger gameMode;
@property (nonatomic, assign) NSInteger openOwl;
@property (nonatomic, assign) NSInteger openSquirrel;

@end