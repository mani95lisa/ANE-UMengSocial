//
//  SocialControler.h
//  UMSocial_Sdk_Demo
//
//  Created by mani on 13-7-18.
//  Copyright (c) 2013年 yeahugo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashRuntimeExtensions.h"
#import "UMSocialSnsService.h"
#import "UMSocialBarViewController.h"

@interface SocialControler : UIViewController
<
UIActionSheetDelegate,
UMSocialUIDelegate
>
{
    UMSocialBar *_socialBar;
}

@property ( nonatomic, assign ) FREContext      *freContext;
@property (strong, nonatomic) UIWindow *window;

-(void) initBar;
-(void) status:(BOOL)visible;
-(void) dataID:(NSString*)dataID shareText:(NSString*)text imageUrl:(NSString*) imageUrl title:(NSString*) title;
-(void) share:(NSString*)dataID shareText:(NSString*)text imageUrl:(NSString*) imageUrl title:(NSString*) title type:(NSString*) type;

@end
