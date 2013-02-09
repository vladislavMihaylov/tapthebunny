
#import "Settings.h"
#import "GameConfig.h"

@implementation Settings

Settings *sharedSettings = nil;

@synthesize soundLevel;
@synthesize gameMode;
@synthesize openAnimals;
@synthesize openBabyMode;

+ (Settings *) sharedSettings
{
    if(!sharedSettings)
    {
        sharedSettings = [[Settings alloc] init];
    }
    
    return sharedSettings;
}

- (id) init
{
    if((self = [super init]))
    {
        //
    }
    
    return self;
}

- (void) dealloc
{
    [self save];
    [super dealloc];
}

#pragma mark -
#pragma mark load/save

- (void) load
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    NSNumber *soundData = [defaults objectForKey: kSoundKey];
    if(soundData)
    {
        self.soundLevel = [soundData integerValue];
    }
    else
    {
        self.soundLevel = 1;
    }
    
    NSNumber *gameModeData = [defaults objectForKey: kGameModeKey];
    if(gameModeData)
    {
        self.gameMode = [gameModeData integerValue];
    }
    else
    {
        self.gameMode = 1;
    }
    
    NSNumber *animalsData = [defaults objectForKey: kAnimalsKey];
    if(animalsData)
    {
        self.openAnimals = [animalsData integerValue];
    }
    else
    {
        self.openAnimals = 0;
    }
    
    NSNumber *openBabyModeData = [defaults objectForKey: kOpenBabyModeKey];
    if(openBabyModeData)
    {
        self.openBabyMode = [openBabyModeData integerValue];
    }
    else
    {
        self.openBabyMode = 0;
    }
}

- (void) save
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject: [NSNumber numberWithInteger: self.soundLevel] forKey: kSoundKey];
    [defaults setObject: [NSNumber numberWithInteger: self.gameMode] forKey: kGameModeKey];
    [defaults setObject: [NSNumber numberWithInteger: self.openAnimals] forKey: kAnimalsKey];
    [defaults setObject: [NSNumber numberWithInteger: self.openBabyMode] forKey: kOpenBabyModeKey];
    
    [defaults synchronize];
}


@end
