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

@interface Login : UIViewController
<
UMSocialUIDelegate
>

@property ( nonatomic, assign ) FREContext      *freContext;
@property (strong, nonatomic) UIWindow *window;

-(void) doLogin:(NSString*) platform;

-(void) cancelLogin:(NSString*) platform;
@end
