//
//  UMUtils.h
//  UMUtils
//
//  Created by luyiyuan on 3/31/12.
//  Copyright (c) umeng.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UM_SAFE_STR(Object) (Object==nil?@"":Object)
#define UMdegreesToRadians(x) (M_PI * (x) / 180.0) //定义弧度到度数的宏

#define UMSYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define UMSYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define UMSYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define UMSYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//logs
/*
 NSString *file = [[NSString stringWithUTF8String:__FILE__] lastPathComponent]; \
 printf("[%s(%f)] [%s:(%s)(%d)] - ",[[UMUtils timeMSString] UTF8String],[NSThread currentThread].threadPriority,[file UTF8String],    __FUNCTION__, __LINE__); \*/

#ifndef UMLog
#define UMLog(format,...) \
{ \
if([UMUtils openLog])\
{ \
UMDebugLog((format),##__VA_ARGS__); \
} \
}
#endif

void UMDebugLog(NSString *format, ...);

@protocol SKStoreProductViewControllerDelegate;

@interface UMUtils : NSObject

#pragma mark self
+ (NSString *)utilsVersion;

#pragma mark dateTime info
+ (NSString *)countryString;//country
+ (NSString *)languageString;//language
+ (NSString *)timezoneString;//timezone
+ (NSString *)dateString;
+ (NSString *)timeString;
+ (NSString *)timeMSString;
+ (NSString *)latString;
+ (NSString *)lngString;

#pragma mark deviceAndOS info
+ (NSString *)deviceIDString;
+ (NSString *)deviceIDAdverString;//just for iOS 6.0 or later,please test in device
+ (NSString *)deviceIDVendorString;//just for iOS 6.0 or later
+ (NSString *)deviceIDMD5String;//idmd5
+ (NSString *)deviceMacString;//mac_adress
+ (NSString *)deviceMacMD5String;//mac_adress_md5
+ (NSString *)openUDIDString;
+ (NSString *)UUIDString;
+ (NSString *)UUIDMD5String;
+ (NSString *)deviceModelString;//device_model
+ (NSString *)resolutionString;//resolution
+ (NSString *)osString;//os
+ (NSString *)osVersionString;//os_version
+ (NSString *)cpuString;//cpu
+ (NSString *)orientationString;
+ (NSString *)deviceJailBreakString;//is_jailbroken
+ (BOOL)isDeviceJailBreak;
+ (BOOL)isPad;

#pragma mark network info
+ (NSString *)accessString;//access
+ (NSString *)carrierString;//carrier


#pragma mark ipa info
+ (NSString *)appPackageNameString;//package_name
+ (NSString *)appDisplayNameString;//display_name
+ (NSString *)appBundleVersionString;//app_version
+ (NSString *)appShortVersionString;//appShortversion
+ (BOOL)isAppPirate;
+ (NSString *)appPirateString;//is_pirated


#pragma mark NSData
+ (NSMutableDictionary *)setNotNullObject:(NSMutableDictionary *)dictionary object:(id)anObject forKey:(id)aKey;


#pragma mark tools
+ (NSString *)md5Value:(NSString *)string;
+ (NSString *)urlEncode:(NSString *)string;
+ (NSString *)base64Encode:(NSString *)string;
+ (NSString *)base64EncodeData:(NSData *)data;

#pragma mark log
+ (void)setOpenLog:(BOOL)openLog;
+ (void)setPrefix:(NSString *)prefix;
+ (BOOL)openLog;

#pragma mark math
+ (int)getRand:(int) aMin max:(int) aMax;

#pragma mark UIKit
+ (void)printViewHierarchy:(UIView *)viewNode depth:(NSUInteger)depth;
+ (void)printViews:(NSArray* )wins depth:(NSUInteger)depth;
+ (UIImage *)addImage:(UIImage *)newImage toImage:(UIImage *)oldImage;

#pragma mark Bunldle
+ (NSString *) getBundleRes: (NSString *) filename bundleName:(NSString *) bundleName;

#pragma mark other
+ (BOOL)canOpenUrl:(NSString *)urlString;
+ (BOOL)openUrl:(NSString *)urlString;
+ (BOOL)makingACall:(NSString *)urlString;
//+ (void)presentStoreProductForApp:(NSString *)appId
//                               in:(id<SKStoreProductViewControllerDelegate>)viewController
//                  completionBlock:(void (^)(BOOL result, NSError *error))block;

#pragma mark json
+ (NSString *)JSONFragment:(id)object;
+ (id)JSONValue:(NSString *)string;

@end

@interface UMUtils (Singleton)
+ (UMUtils*) sharedInstance;
@end
