//
//  UMSocialBarViewController.h
//  SocialSDK
//
//  Created by Jiahuan Ye on 12-8-21.
//  Copyright (c) umeng.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"
#import "UMSocialBar.h"

@interface UMSocialBarViewController : UIViewController<UMSocialUIDelegate>
{
    UMSocialBar *_socialBar;
    UIWebView   *_webView;
}

-(void) dataID:(NSString*)dataID;

@end
