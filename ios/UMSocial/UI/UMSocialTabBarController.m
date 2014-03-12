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
#import "UMSocial.h"

@implementation UMSocialTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BOOL isOauth = [UMSocialAccountManager isOauthWithPlatform:UMShareToSina];
    NSLog(@"isOauth %hhd", isOauth);
}

-(void) viewDidAppear:(BOOL)animated
{
//    UINavigationController *oauthController = [[UMSocialControllerService defaultControllerService] getSocialOauthController:UMShareToSina];
//    [self presentModalViewController:oauthController animated:YES];
//    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;      //设置回调对象
}

//实现回调方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    if (response.viewControllerType == UMSViewControllerOauth) {
        NSLog(@"didFinishOauthAndGetAccount response is %@",response);
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"bbbb");
    
    
    
    
    return;
    
    [UMSocialControllerService defaultControllerService].socialUIDelegate = self;
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        NSLog(@"login response is %@",response);
        //          获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            NSLog(@"username is %@, uid is %@, token is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken);
        }
        //这里可以获取到腾讯微博openid,Qzone的token等
        /*
         if ([platformName isEqualToString:UMShareToTencent]) {
         [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToTencent completion:^(UMSocialResponseEntity *respose){
         NSLog(@"get openid  response is %@",respose);
         }];
         }
         */
    });
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    for (UIViewController *viewController in self.viewControllers) {
        [viewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    }
}

@end
