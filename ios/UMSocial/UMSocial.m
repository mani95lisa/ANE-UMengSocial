//
//  UMengSocial.m
//  UMengSocial
//
//  Created by mani on 13-7-17.
//  Copyright (c) 2013年 yeahugo. All rights reserved.
//

#import "UMSocial.h"
#import "FlashRuntimeExtensions.h"
#import "SocialControler.h"
#import "Login.h"
#import "UMSocialData.h"
#import "UMSocialConfig.h"
#import "UMSocialWechatHandler.h"

@implementation UMSocial

FREObject init(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    NSLog(@"Call Init Function");
    
    uint32_t stringLength;
    const uint8_t* appKey;
    NSString *appKeyString = nil;
    
    if(argv[0] && (FREGetObjectAsUTF8(argv[0], &stringLength, &appKey) == FRE_OK)){
        appKeyString = [NSString stringWithUTF8String:(char*)appKey];
        [UMSocialData setAppKey:appKeyString];
    }
    
    const uint8_t* wechatKey;
    NSString *wechatKeyString = nil;
    if(argv[1] && (FREGetObjectAsUTF8(argv[1], &stringLength, &wechatKey) == FRE_OK)){
        wechatKeyString = [NSString stringWithUTF8String:(char*)wechatKey];
        [UMSocialWechatHandler setWXAppId:wechatKeyString url:nil];
    }
    
//    uint32_t useSocialBar = 0;
//    BOOL status = YES;
//    
//    if(argv[2] && (FREGetObjectAsUint32(argv[2], &useSocialBar)==FRE_OK)){
//        status = useSocialBar == 1;
//        if(status){
//            SocialControler* sc = funcData;
//            [sc initBar];
//        }
//    }
    
    [UMSocialConfig setSupportSinaSSO:NO];
    
    NSLog(@"Called Init Function Finished %@", appKeyString);
    
    return nil;
}

FREObject status(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    NSLog(@"Call status Function");
    
    uint32_t statusInt = 0;
    BOOL status = YES;
    
    if(argv[0] && (FREGetObjectAsUint32(argv[0], &statusInt)==FRE_OK)){
        status = statusInt == 1;
    }
    
    SocialControler* sc = funcData;
    [sc status:status];

    NSLog(@"Called status Function %c, %d", status, statusInt);
    
    return nil;
}

FREObject login(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    
    NSLog(@"Call login Function");
    
    const uint8_t* platform;
    uint32_t stringLength;
    NSString *platformString = nil;
    
    if(argv[0] && (FREGetObjectAsUTF8(argv[0], &stringLength, &platform) == FRE_OK)){
        platformString = [NSString stringWithUTF8String:(char*)platform];
    }
    
    Login* lc = [[Login alloc] init];
    lc.freContext = context;
    lc.window = funcData;
    
    [lc doLogin:platformString];
    
    return nil;
}

FREObject cancelLogin(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    
    NSLog(@"Call cancelLogin Function");
    
    const uint8_t* platform;
    uint32_t stringLength;
    NSString *platformString = nil;
    
    if(argv[0] && (FREGetObjectAsUTF8(argv[0], &stringLength, &platform) == FRE_OK)){
        platformString = [NSString stringWithUTF8String:(char*)platform];
    }
    
        NSLog(@"Call cancelLogin Function %@", platformString);
    
    Login* lc = [[Login alloc] init];
    lc.freContext = context;
    lc.window = funcData;
    
    [lc cancelLogin:platformString];
    
    return nil;
}

FREObject dataID(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    NSLog(@"Call dataID Function");
    
    const uint8_t* dataID;
    uint32_t stringLength;
    NSString *dataIDString = nil;
    
    const uint8_t* sahreText;
    NSString *shareTextString = nil;
    
    const uint8_t* imageUrl;
    NSString *imageUrlString = nil;
    
    const uint8_t* title;
    NSString *titleString = nil;
    
    if(argv[0] && (FREGetObjectAsUTF8(argv[0], &stringLength, &dataID) == FRE_OK)){
        dataIDString = [NSString stringWithUTF8String:(char*)dataID];
    }
    
    if(argv[1] && (FREGetObjectAsUTF8(argv[1], &stringLength, &sahreText) == FRE_OK)){
        shareTextString = [NSString stringWithUTF8String:(char*)sahreText];
    }
    
    if(argv[2] && (FREGetObjectAsUTF8(argv[2], &stringLength, &imageUrl) == FRE_OK)){
        imageUrlString = [NSString stringWithUTF8String:(char*)imageUrl];
    }
    
    if(argv[3] && (FREGetObjectAsUTF8(argv[3], &stringLength, &title) == FRE_OK)){
        titleString = [NSString stringWithUTF8String:(char*)title];
    }
    
    SocialControler* sc = funcData;
    [sc dataID:dataIDString shareText:shareTextString imageUrl:imageUrlString title:titleString];
    
    NSLog(@"Called dataID Function DataID: %@, shareText: %@, imageURL: %@, title: %@", dataIDString, shareTextString, imageUrlString, titleString);
    
    return nil;
}

FREObject share(FREContext context, void* funcData, uint32_t argc, FREObject argv[]){
    NSLog(@"Call share Function");
    
    const uint8_t* dataID;
    uint32_t stringLength;
    NSString *dataIDString = nil;
    
    const uint8_t* sahreText;
    NSString *shareTextString = nil;
    
    const uint8_t* imageUrl;
    NSString *imageUrlString = nil;
    
    const uint8_t* title;
    NSString *titleString = nil;
    
    const uint8_t* type;
    NSString *typeString = nil;
    
    if(argv[0] && (FREGetObjectAsUTF8(argv[0], &stringLength, &dataID) == FRE_OK)){
        dataIDString = [NSString stringWithUTF8String:(char*)dataID];
    }
    
    if(argv[1] && (FREGetObjectAsUTF8(argv[1], &stringLength, &sahreText) == FRE_OK)){
        shareTextString = [NSString stringWithUTF8String:(char*)sahreText];
    }
    
    if(argv[2] && (FREGetObjectAsUTF8(argv[2], &stringLength, &imageUrl) == FRE_OK)){
        imageUrlString = [NSString stringWithUTF8String:(char*)imageUrl];
    }
    
    if(argv[3] && (FREGetObjectAsUTF8(argv[3], &stringLength, &title) == FRE_OK)){
        titleString = [NSString stringWithUTF8String:(char*)title];
    }
    
    if(argv[4] && (FREGetObjectAsUTF8(argv[4], &stringLength, &type) == FRE_OK)){
        typeString = [NSString stringWithUTF8String:(char*)type];
    }
    
    NSLog(@"Called share Function DataID: %@, shareText: %@, imageURL: %@, title: %@, type: %@", dataIDString, shareTextString, imageUrlString, titleString, typeString);
    
    SocialControler* sc = funcData;
    [sc share:dataIDString shareText:shareTextString imageUrl:imageUrlString title:titleString type:typeString];
    
    return nil;
}

void AirUMSocialContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest,
                             const FRENamedFunction** functionsToSet){
    uint numOfFun = 6;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * numOfFun);
    *numFunctionsToTest = numOfFun;
    
    SocialControler* socialControler = [[SocialControler alloc] init];
    socialControler.freContext = ctx;
    id delegate = [[UIApplication sharedApplication] delegate];
    UIWindow * win = [delegate window];
    socialControler.window = win;
    
    FRESetContextNativeData( ctx, socialControler );
    
    func[0].name = (const uint8_t*) "init";
    func[0].functionData = socialControler;
    func[0].function = &init;
    
    func[1].name = (const uint8_t*) "status";
    func[1].functionData = socialControler;
    func[1].function = &status;
    
    func[2].name = (const uint8_t*) "dataID";
    func[2].functionData = socialControler;
    func[2].function = &dataID;
    
    func[3].name = (const uint8_t*) "share";
    func[3].functionData = socialControler;
    func[3].function = &share;
    
    func[4].name = (const uint8_t*) "login";
    func[4].functionData = win;
    func[4].function = &login;
    
    func[5].name =(const uint8_t*) "cancelLogin";
    func[5].functionData = win;
    func[5].function = &cancelLogin;
    
    *functionsToSet = func;
    
    NSLog(@"Inited");
}

void UMengExtFinalizer(void* extData)
{
    NSLog(@"Finalize!");
    return;
}

void AirUMSocialContextFinalizer(FREContext ctx) { }
void AirUMSocialFinalizer(void *extData) { }

void AirUMSocialInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
    *extDataToSet = NULL;
    *ctxInitializerToSet = &AirUMSocialContextInitializer;
    *ctxFinalizerToSet = &AirUMSocialContextFinalizer;
}

@end
