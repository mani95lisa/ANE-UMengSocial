//
//  UMSocialTabViewController.m
//  SocialSDK
//
//  Created by yeahugo on 13-1-25.
//  Copyright (c) 2013年 Umeng. All rights reserved.
//

#import "UMSocialTabBarController.h"
#import "UMSocialLoginViewController.h"
#import "UMSocialSnsViewController.h"
#import "UMSocialBarViewController.h"

@implementation UMSocialTabBarController

- (void)viewDidLoad
{
    UMSocialSnsViewController *snsViewController = [[UMSocialSnsViewController alloc] initWithNibName:@"UMSocialSnsViewController" bundle:nil];
    
    UMSocialLoginViewController *loginViewController = [[UMSocialLoginViewController alloc] initWithNibName:@"UMSocialLoginViewController" bundle:nil];
    loginViewController.title = @"授权";
    loginViewController.tabBarItem.image = [UIImage imageNamed:@"UMS_account"];
    
    UMSocialBarViewController *barViewController = [[UMSocialBarViewController alloc] initWithNibName:@"UMSocialBarViewController" bundle:nil];
    barViewController.title = @"操作栏";
    barViewController.tabBarItem.image = [UIImage imageNamed:@"UMS_bar"];
        
    [self setViewControllers:[NSArray arrayWithObjects:snsViewController,loginViewController,barViewController,nil]];
    
    [super viewDidLoad];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    for (UIViewController *viewController in self.viewControllers) {
        [viewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

@end
