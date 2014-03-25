//
//  Login.m
//  UMSocial
//
//  Created by mani on 14-3-12.
//  Copyright (c) 2014年 pamakids. All rights reserved.
//

#import "Login.h"
#import "UMSocial.h"
#import "UMSocialAccountManager.h"

#define AuthResult (const uint8_t*)"AuthResult"
#define CancelAuthResult (const uint8_t*)"CancelAuthResult"

@interface Login ()

@end

@implementation Login

@synthesize window = _window;
@synthesize loginPlatform = _loginPlatform;

-(void) cancelLogin:(NSString *)platform
{
    NSLog(@"to cancel login 2 %@ ", platform);
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:platform];
    
    NSString *platformType = [UMSocialSnsPlatformManager getSnsPlatformString:snsPlatform.shareToType];
    
    [[UMSocialDataService defaultDataService] requestUnOauthWithType:platformType completion:^(UMSocialResponseEntity *response) {
        NSLog(@"unOauth response is %@",response);
        NSString *result = [NSString stringWithFormat:@"%@", [response data]];
        [self release];
        FREDispatchStatusEventAsync(self.freContext, CancelAuthResult, (const uint8_t *)[result UTF8String]);
    }];
}

-(void) doLogin:(NSString*)platform
{
    NSLog(@"to get isOauth");
    
    BOOL isOauth = [UMSocialAccountManager isOauthWithPlatform:platform];
    self.loginPlatform = platform;
    NSLog(@"isOauth %hhd", isOauth);
    
    if(isOauth){
        NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
        UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:platform];
        NSLog(@"Release if oauthed %@", sinaAccount);
        [self release];
        FREDispatchStatusEventAsync(self.freContext, AuthResult, (const uint8_t *)[[sinaAccount description] UTF8String]);
    }else{
        UIViewController *uic = self.window.rootViewController;
        [uic addChildViewController:self];
        [uic.view addSubview:self.view];
        
        UMSocialControllerService *ucs = [UMSocialControllerService defaultControllerService];
        ucs.socialUIDelegate = self;
        UINavigationController *oauth = [ucs getSocialOauthController:UMShareToSina];
        [self presentModalViewController:oauth animated:YES];
    }
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"Response %@, %d", response, UMSViewControllerOauth);
    if (response.viewControllerType == UMSViewControllerOauth) {
//        NSString *result = [NSString stringWithFormat:@"%@", [response data]];
        NSDictionary *snsAccountDic = [UMSocialAccountManager socialAccountDictionary];
        UMSocialAccountEntity *sinaAccount = [snsAccountDic valueForKey:self.loginPlatform];

        NSLog(@"Removed From Superview");
        [self.view removeFromSuperview];
        [self release];
        
        FREDispatchStatusEventAsync(self.freContext, AuthResult, (const uint8_t *)[[sinaAccount description] UTF8String]);
//        FREDispatchStatusEventAsync(self.freContext, AuthResult, (const uint8_t *)[result UTF8String]);
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
