//
//  UMSocialSnsViewController.h
//  SocialSDK
//
//  Created by yeahugo on 13-5-19.
//  Copyright (c) 2013年 Umeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialControllerService.h"

@interface UMSocialSnsViewController : UIViewController
<
    UIActionSheetDelegate,
    UMSocialUIDelegate
>
{
    IBOutlet UIButton *_shareButton1;
    IBOutlet UIButton *_shareButton3;
}

-(IBAction)showShareList1:(id)sender;

-(IBAction)showShareList3:(id)sender;

@end
