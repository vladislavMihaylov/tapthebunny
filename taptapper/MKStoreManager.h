//
//  StoreManager.h
//  MKSync
//
//  Created by Mugunth Kumar on 17-Oct-09.
//  Copyright 2009 MK Inc. All rights reserved.
//  mugunthkumar.com

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "MKStoreObserver.h"

@protocol MKStoreKitDelegate <NSObject>
@optional
- (void)productAPurchased;
- (void)productBPurchased;
- (void)failed;
@end

@class CartScene;

@interface MKStoreManager : NSObject<SKProductsRequestDelegate> {

	NSMutableArray *purchasableObjects;
	MKStoreObserver *storeObserver;	

	id<MKStoreKitDelegate> delegate;
    
    //NSMutableArray *cost;
    //CartScene *cartScene;
}

@property (nonatomic, retain) CartScene *cartScene;
@property (nonatomic, retain) id<MKStoreKitDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *purchasableObjects;
@property (nonatomic, retain) MKStoreObserver *storeObserver;

@property (nonatomic, copy) void (^onRestoreFailed)(NSError* error);
@property (nonatomic, copy) void (^onRestoreCompleted)();


- (void) requestProductData;

- (void) buyFeatureA; // expose product buying functions, do not expose
- (void) buyFeatureB; // your product ids. This will minimize changes when you change product ids later

// do not call this directly. This is like a private method
- (void) buyFeature:(NSString*) featureId;

-(void)paymentCanceled;

- (void) failedTransaction: (SKPaymentTransaction *)transaction;
-(void) provideContent: (NSString*) productIdentifier;

+ (MKStoreManager*)sharedManager;

+ (BOOL) featureAPurchased;
+ (BOOL) featureBPurchased;

+(void) loadPurchases;
+(void) updatePurchases;

@end
