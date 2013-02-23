
#define kGameWidth    480
#define kGameHeight   320

#define kFaceBookBtnTag     100
#define kTwitterBtnTag      101

#define kSpeedBtnTag        110
#define kSoundBtnTag        111

#define kFirstSlideTag      105
#define kSecondSlideTag     106

#define kSoundKey           @"soundKey"
#define kGameModeKey        @"gameModeKey"
#define kAnimalsKey         @"animalsKey"
#define kOpenBabyModeKey    @"openBabyModeKey"
#define kEnabledBabyModeKey @"enabledBabyModeKey"

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define APP_ID 602012993

extern BOOL isGameActive;
extern BOOL isFirstRun;

extern float GameCenterX;
extern float GameCenterY;

extern NSInteger animalNum;
extern NSInteger sceneNum;

extern NSInteger lenght;
extern NSInteger rasstoyanie;

extern NSString *postFix;

extern CGPoint posForSprite1;
extern CGPoint posForSprite2;
extern CGPoint posForSprite3;

extern CGPoint animalFlyPoint;

extern CGPoint posForBoxSprite;
extern CGPoint posForBoxSpriteHide;
extern CGPoint posForMenu;
extern CGPoint posForOpenMenu;

extern CGPoint posForNextTutorialBtn;
extern CGPoint posForExitTutorialBtn;

extern CGPoint posForOptionsMenu;
extern CGPoint posForSoundBtnInGameMenu;
extern CGPoint posForSoundBtnInGameMenuHide;

extern float coefficientForTutorial;

extern float heightForStar;
extern float widthForStar;
extern float stepOfStar;

extern float startBtnHeight;
extern float firstBtnHeight;
extern float secondBtnHeight;

extern float slideScale;

extern float xPosAnimBtn;
extern float xPosS1;
extern float xPosS2;
extern float xPosS3;
extern float displaymentX;
extern float anBtnHeightCoef;
extern float BMBtnHeightCoef;
extern float speedBtnHeightCoef;

extern float speedBtnScale;
