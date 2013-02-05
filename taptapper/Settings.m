
#import "Settings.h"
#import "GameConfig.h"

@implementation Settings

Settings *sharedSettings = nil;

@synthesize soundLevel;
@synthesize gameMode;
@synthesize openOwl;
@synthesize openSquirrel;

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
        self.gameMode = 0;
    }
    
    NSNumber *owlData = [defaults objectForKey: kOwlKey];
    if(owlData)
    {
        self.openOwl = [owlData integerValue];
    }
    else
    {
        self.openOwl = 0;
    }
    
    NSNumber *squirrelData = [defaults objectForKey: kSquirrelKey];
    if(squirrelData)
    {
        self.openSquirrel = [squirrelData integerValue];
    }
    else
    {
        self.openSquirrel = 0;
    }
}

- (void) save
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject: [NSNumber numberWithInteger: self.soundLevel] forKey: kSoundKey];
    [defaults setObject: [NSNumber numberWithInteger: self.gameMode] forKey: kGameModeKey];
    [defaults setObject: [NSNumber numberWithInteger: self.openOwl] forKey: kOwlKey];
    [defaults setObject: [NSNumber numberWithInteger: self.openSquirrel] forKey: kSquirrelKey];
    
    [defaults synchronize];
}


@end
