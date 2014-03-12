//
//  UMSocialSnsViewController.h
//  SocialSDK
//
//  Created by yeahugo on 13-5-19.
//  Copyright (c) 2013年 Umeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialControllerService.h"
#import "UMSocialShakeService.h"

@interface UMSocialSnsViewController : UIViewController
<
    UIActionSheetDelegate,
    UMSocialUIDelegate,
    UMSocialShakeDelegate
>
{
    IBOutlet UIButton *_shareButton1;
    IBOutlet UIButton *_shareButton2;
    IBOutlet UIButton *_shareButton3;
    IBOutlet UIButton *_shareButton4;
}

-(IBAction)showShareList1:(id)sender;

-(IBAction)showShareList3:(id)sender;

-(IBAction)showShareList4:(id)sender;

-(IBAction)setShakeSns:(id)sender;

@end
