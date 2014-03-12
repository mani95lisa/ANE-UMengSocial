 //
//  UMSocialSnsViewController.m
//  SocialSDK
//
//  Created by yeahugo on 13-5-19.
//  Copyright (c) 2013年 Umeng. All rights reserved.
//

#import "UMSocialSnsViewController.h"
#import "UMSocialLoginViewController.h"
#import "UMSocialBarViewController.h"

#import "UMSocial.h"
#import "UMSocialScreenShoter.h"

#define kTagShareEdit 101
#define kTagSharePost 102

@interface UMSocialSnsViewController ()

@end

@implementation UMSocialSnsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

//下面可以设置根据点击不同的分享平台，设置不同的分享文字
/*
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    if ([platformName isEqualToString:UMShareToSina]) {
        socialData.shareText = @"分享到新浪微博";
    }
    else{
        socialData.shareText = @"分享内嵌文字";
    }
}
*/

-(void)didCloseUIViewController:(UMSViewControllerType)fromViewControllerType
{
    NSLog(@"didClose is %d",fromViewControllerType);
}

//下面得到分享完成的回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController with response is %@",response);
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

//下面设置点击分享列表之后，可以直接分享
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

//-(UMSocialShakeConfig)didShakeWithShakeConfig
//{
//    //下面可以设置你用自己的方法来得到的截屏图片
////    [UMSocialShakeService setScreenShotImage:[UIImage imageNamed:@"UMS_social_demo"]];
//    return UMSocialShakeConfigDefault;
//}

-(void)didCloseShakeView
{
    NSLog(@"didCloseShakeView");
}

-(void)didFinishShareInShakeView:(UMSocialResponseEntity *)response
{
    NSLog(@"finish share with response is %@",response);
}

/*
 注意分享到新浪微博我们使用新浪微博SSO授权，你需要在xcode工程设置url scheme，并重写AppDelegate中的`- (BOOL)application openURL sourceApplication`方法，详细见文档。否则不能跳转回来原来的app。
 */
-(IBAction)showShareList1:(id)sender
{
    NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";             //分享内嵌文字
    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];          //分享内嵌图片
    
//    //如果得到分享完成回调，需要设置delegate为self
//    [UMSocialSnsService presentSnsIconSheetView:self appKey:UmengAppkey shareText:shareText shareImage:shareImage shareToSnsNames:nil delegate:self];
}

-(IBAction)setShakeSns:(id)sender
{
    //可以设置响应摇一摇阈值，数值越低越灵敏，默认是0.8
    [UMSocialShakeService setShakeThreshold:1.5];
    NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";             //分享内嵌文字
    //下面设置delegate为self，执行摇一摇成功的回调，不执行回调可以设为nil
    [UMSocialShakeService setShakeToShareWithTypes:nil
                                         shareText:shareText
                                      screenShoter:[UMSocialScreenShoterDefault screenShoter]
                                  inViewController:self
                                          delegate:self];    
}

/*
 自定义分享样式，可以自己构造分享列表页面
 
 */
-(IBAction)showShareList3:(id)sender
{    
    UIActionSheet * editActionSheet = [[UIActionSheet alloc] initWithTitle:@"图文分享" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for (NSString *snsName in [UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray) {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
        [editActionSheet addButtonWithTitle:snsPlatform.displayName];
    }
    [editActionSheet addButtonWithTitle:@"取消"];
    editActionSheet.tag = kTagShareEdit;
    editActionSheet.cancelButtonIndex = editActionSheet.numberOfButtons - 1;
    [editActionSheet showFromTabBar:self.tabBarController.tabBar];
    editActionSheet.delegate = self;
}

-(IBAction)showShareList4:(id)sender
{
    UIActionSheet * editActionSheet = [[UIActionSheet alloc] initWithTitle:@"直接分享到微博" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for (NSString *snsName in [UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray) {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
        [editActionSheet addButtonWithTitle:snsPlatform.displayName];
    }
    [editActionSheet addButtonWithTitle:@"取消"];
    editActionSheet.tag = kTagSharePost;
    editActionSheet.cancelButtonIndex = editActionSheet.numberOfButtons - 1;
    [editActionSheet showFromTabBar:self.tabBarController.tabBar];
    editActionSheet.delegate = self;
}

/*
 在自定义分享样式中，根据点击不同的点击来处理不同的的动作
 
 */
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex + 1 >= actionSheet.numberOfButtons ) {
        return;
    }
    
    //分享编辑页面的接口,snsName可以换成你想要的任意平台，例如UMShareToSina,UMShareToWechatTimeline
    NSString *snsName = [[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray objectAtIndex:buttonIndex];
    NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";
    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];
    if (actionSheet.tag == kTagShareEdit) {
        //设置分享内容，和回调对象
        [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:shareImage socialUIDelegate:self];
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
        snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    } else if (actionSheet.tag == kTagSharePost){
        [[UMSocialDataService defaultDataService] postSNSWithTypes:@[snsName] content:shareText image:shareImage location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity * response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"成功" message:@"分享成功" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                [alertView show];
            } else if(response.responseCode != UMSResponseCodeCancel) {
                if (response.responseCode == UMSResponseCodeSuccess) {
                    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"失败" message:@"分享失败" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
                    [alertView show];
                }
            }
        }];
    }
}

- (void)viewDidLoad
{
    _shareButton1.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/6);
    _shareButton2.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/6 *2);
    _shareButton3.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/6 *3);
    _shareButton4.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/6 *4);
    
    [super viewDidLoad];
    self.title = @"分享";
    self.tabBarItem.image = [UIImage imageNamed:@"UMS_share"];
}


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    /*
     如果要弹出的分享列表支持不同方向，需要在这里设置一下重新布局
     如果当前UIViewController有UINavigationController,则用self.navigationController.view，否则用self.view
     */
    UIView * iconActionSheet = [self.tabBarController.view viewWithTag:kTagSocialIconActionSheet];
    [iconActionSheet setNeedsDisplay];
    UIView * shakeView = [self.tabBarController.view viewWithTag:kTagSocialShakeView];
    [shakeView setNeedsDisplay];
}


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    _shareButton1.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/6);
    _shareButton2.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/6 *2);
    _shareButton3.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/6 *3);
    _shareButton4.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/6 *4);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
