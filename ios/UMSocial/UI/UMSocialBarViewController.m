//
//  UMSocialBarViewController.m
//  SocialSDK
//
//  Created by Jiahuan Ye on 12-8-21.
//  Copyright (c) umeng.com All rights reserved.
//

#import "UMSocialBarViewController.h"
#import "UMSocialSnsViewController.h"
//#import "AppDelegate.h"

@interface UMSocialBarViewController ()

@end


@implementation UMSocialBarViewController

-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
    NSLog(@"didClose is %d",fromViewControllerType);
}

- (void)viewDidLoad
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    size = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? size : CGSizeMake(size.height, size.width);
    
    UMSocialData *socialData = [[UMSocialData alloc] initWithIdentifier:@"UMSocialDemo"];
    socialData.shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。";         //分享内嵌文字
    socialData.shareImage = [UIImage imageNamed:@"UMS_social_demo"];           //分享内嵌图片
    _socialBar = [[UMSocialBar alloc] initWithUMSocialData:socialData withViewController:self];
    //下面设置回调对象，如果你不需要得到回调方法也可以不设置
    _socialBar.socialUIDelegate = self;
    _socialBar.center = CGPointMake(size.width/2, size.height - 93);
    [self.view addSubview:_socialBar];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [_socialBar requestUpdateButtonNumber];
    [super viewWillAppear:animated];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController is %@",response);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    CGSize size = [UIScreen mainScreen].bounds.size;
    size = UIInterfaceOrientationIsPortrait(self.interfaceOrientation) ? size : CGSizeMake(size.height, size.width);
    float barHeight = 44;
    _socialBar.center = CGPointMake(size.height/2, size.width  - barHeight - _socialBar.frame.size.height );
}

@end
