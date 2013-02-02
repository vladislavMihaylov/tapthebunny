//
//  AppDelegate.m
//  doodleCalls
//
//  Created by Vlad on 04.12.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"

#import "CCBReader.h"

#import "GameConfig.h"
#import "Settings.h"

#import "SHKConfiguration.h"
#import "MySHKConfigurator.h"

#import "SHKFacebook.h"

@implementation AppController

@synthesize window=window_, navController=navController_, director=director_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DefaultSHKConfigurator *configurator = [[[MySHKConfigurator alloc] init] autorelease];
    
    [SHKConfiguration sharedInstanceWithConfigurator: configurator];
    
    [[Settings sharedSettings] load];
    
	// Create the main window
	window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];


	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];

	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];

	director_.wantsFullScreenLayout = YES;

	// Display FSP and SPF
	[director_ setDisplayStats: NO];

	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];

	// attach the openglView to the director
	[director_ setView:glView];

	// for rotation and other messages
	[director_ setDelegate:self];

	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
//	[director setProjection:kCCDirectorProjection3D];

	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");

	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"


	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];

	// and add the scene to the stack. The director will run it when it automatically when the view is displayed.
	//[director_ pushScene: [IntroLayer scene]];
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        postFix = @"-ipad";
        
        GameCenterX = 512;
        GameCenterY = 384;
        
        posForSprite1 = ccp(200, 223);
        posForSprite2 = ccp(512, 223);
        posForSprite3 = ccp(824, 223);
        
        animalFlyPoint = ccp(1024, 900);
        
        posForBoxSprite = ccp(696, 0);
        posForBoxSpriteHide = ccp(1024, 0);
        posForMenu = ccp(330, 0);
        
        posForOptionsMenu = ccp(270, 80);
        
        posForOkBtn = ccp(80, 120);
        
        posForSoundBtnInGameMenu = ccp(810, 80);
        posForSoundBtnInGameMenuHide = ccp(1140, 80);
        
        heightForStar = 700;
        widthForStar = 315;
        stepOfStar = 70;
        
        startBtnHeight = 80;
        firstBtnHeight = 185;
        secondBtnHeight = 260;
        
        slideScale = 0.9;
    }
    else
    {
        postFix = @"";
        
        GameCenterX = 240;
        GameCenterY = 160;
        
        posForSprite1 = ccp(90, 84);
        posForSprite2 = ccp(240, 84);
        posForSprite3 = ccp(390, 84);
        
        animalFlyPoint = ccp(480, 350);
        
        posForBoxSprite = ccp(322, 0);
        posForBoxSpriteHide = ccp(480, 0);
        posForMenu = ccp(165, 0);
        
        posForOptionsMenu = ccp(140, 50);
        
        posForOkBtn = ccp(40, 60);
        
        posForSoundBtnInGameMenu = ccp(380, 40);
        posForSoundBtnInGameMenuHide = ccp(545, 40);
        
        heightForStar = 290;
        widthForStar = 125;
        stepOfStar = 40;
        
        startBtnHeight = 50;
        firstBtnHeight = 110;
        secondBtnHeight = 150;
        
        slideScale = 1;
    }
    
    CCScene* mainScene = [CCBReader sceneWithNodeGraphFromFile: [NSString stringWithFormat: @"MainMenuScene%@.ccbi", postFix]];
    [director_ pushScene: mainScene];
	
	// Create a Navigation Controller with the Director
	navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;
	
	// set the Navigation Controller as the root view controller
//	[window_ addSubview:navController_.view];	// Generates flicker.
	[window_ setRootViewController:navController_];
	
	// make main window visible
	[window_ makeKeyAndVisible];
	
	return YES;
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}


// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
	//if( [navController_ visibleViewController] == director_ )
	//	[director_ pause];
    
    [[CCDirector sharedDirector] pause];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
	//if( [navController_ visibleViewController] == director_ )
	//	[director_ resume];
    [[CCDirector sharedDirector] resume];
    
    [SHKFacebook handleDidBecomeActive]; /////////////////////////////////////////////////////////////////////////////////////////
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
	//if( [navController_ visibleViewController] == director_ )
	//	[director_ stopAnimation];
    [[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
	//if( [navController_ visibleViewController] == director_ )
	//	[director_ startAnimation];
    [[CCDirector sharedDirector] startAnimation];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
    
    [SHKFacebook handleWillTerminate]; /////////////////////////////////////////////////////////////////////////////////////////
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void) dealloc
{
	[window_ release];
	[navController_ release];

	[super dealloc];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)handleOpenURL:(NSURL*)url
{
    NSString* scheme = [url scheme];
    NSString* prefix = [NSString stringWithFormat:@"fb%@", SHKCONFIG(facebookAppId)];
    if ([scheme hasPrefix:prefix])
        return [SHKFacebook handleOpenURL:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self handleOpenURL:url];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@end

