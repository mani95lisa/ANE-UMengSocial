//
//  UMSocialSnsViewController.m
//  SocialSDK
//
//  Created by yeahugo on 13-5-19.
//  Copyright (c) 2013年 Umeng. All rights reserved.
//

#import "UMSocialSnsViewController.h"

#import "SocialControler.h"
#import "UMSocialAFHTTPClient.h"
#import "UMImageView.h"
#import "UMUtils.h"

#import "UMSocial.h"
#import "WXApiObject.h"
#import "UMSocialSnsService.h"
#import "UMSocialSnsPlatformManager.h"

@interface UMSocialSnsViewController ()

@end

@implementation UMSocialSnsViewController

@synthesize postsDic = _postsDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //设置黑色主题
//        [UMSocialConfig setTheme:UMSocialThemeBlack];
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

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSLog(@"didFinishGetUMSocialDataInViewController is %@",response);
}


/*
 注意分享到新浪微博我们使用新浪微博SSO授权，你需要在xcode工程设置url scheme，并重写AppDelegate中的`- (BOOL)application openURL sourceApplication`方法，详细见文档。否则不能跳转回来原来的app。
 */
-(IBAction)showShareList1:(id)sender
{    
    //设置微信图文分享你可以用下面两种方法
    //1.用微信分享应用类型，用户分享给好友，对方点击跳转到手机应用或者打开url页面。需要另外设置应用下载地址，否则点击朋友圈进入友盟主页
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    [UMSocialData defaultData].extConfig.appUrl = @"http://pipilu.pamakids.com/sb";//设置你应用的下载地址
    
    //2.用微信web类型，用户点击直接打开web
    /*    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeOther;
     WXWebpageObject *webObject = [WXWebpageObject object];
     webObject.webpageUrl = @"https://www.umeng.com"; //设置你自己的url地址
     [UMSocialData defaultData].extConfig.wxMediaObject = webObject;
     */
    
    NSString *shareText = [UMSocialData defaultData].shareText;      //分享内嵌文字
    UIImage *shareImage = [UMSocialData defaultData].shareImage;          //分享内嵌图片

    [UMSocialSnsService presentSnsIconSheetView:self appKey:@"51bd6e0e56240b684005468f" shareText:shareText shareImage:shareImage shareToSnsNames:nil delegate:self];
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
    
     //分享编辑页面的接口
    NSString *snsName = [[UMSocialSnsPlatformManager sharedInstance].allSnsValuesArray objectAtIndex:buttonIndex];
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:snsName];
    snsPlatform.snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}

- (void)viewDidLoad
{
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.center = CGPointMake(160, 200);
    [self.view addSubview:_activityIndicatorView];
    [_activityIndicatorView startAnimating];
    
    _shareButton1.center = CGPointMake(self.tabBarController.view.bounds.size.width/2, _shareButton1.center.y);
     _shareButton3.center = CGPointMake(self.tabBarController.view.bounds.size.width/2, _shareButton3.center.y);
    
    NSDictionary *postsDic = [[NSUserDefaults standardUserDefaults] valueForKey:@"umengPost"];
    
    if (postsDic != nil) {
        self.postsDic = postsDic;
        NSString *title = [self.postsDic  valueForKey:@"title"];
        NSString *url = [self.postsDic  valueForKey:@"url"];
        NSString *shareText = [NSString stringWithFormat:@"%@  %@",title,url];
        
        //设置分享内嵌文字
        [UMSocialData defaultData].shareText = shareText;
    }
    else{
        [UMSocialData defaultData].shareText = @"友盟社会化分享 http://www.umeng.com/";
    }

    UMSocialAFHTTPClient *httpClient = [UMSocialAFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://blog.umeng.com/"]];
    [httpClient getPath:@"/api/get_recent_posts/" parameters:nil success:^(UMSocialAFHTTPRequestOperation *operation, id responseObject){
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic = [UMUtils JSONValue:jsonString];

        [_activityIndicatorView stopAnimating];
        
        NSDictionary *postsDic = [[NSDictionary alloc] initWithDictionary:[[jsonDic valueForKey:@"posts"] objectAtIndex:0]];
        self.postsDic = postsDic;

        [[NSUserDefaults standardUserDefaults] setValue:self.postsDic forKey:@"umengPost"];
        
        NSString *title = [self.postsDic  valueForKey:@"title"];
        NSString *url = [self.postsDic  valueForKey:@"url"];
        NSString *shareText = [NSString stringWithFormat:@"%@  %@",title,url];
        [UMSocialData defaultData].shareText = shareText;
        if ([[self.postsDic valueForKey:@"attachments"] count] > 0) {
            NSString *imageUrl = [[[self.postsDic valueForKey:@"attachments"] objectAtIndex:0] valueForKey:@"url"];
            UMImageView *imageView = [[UMImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"icon"]];
            imageView.imageURL = [NSURL URLWithString:[imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [UMSocialData defaultData].shareImage = imageView.image;
        }
        else{
            [UMSocialData defaultData].shareImage = [UIImage imageNamed:@"icon"];
        }
    } failure:^(UMSocialAFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"error is %@ %d",error,error.code);
        if (error.code == -1009) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取数据失败" message:@"当前设备的网络状态不正常，请稍后重试" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil];
            [alertView show];
        }
        else{
            NSLog(@"connect to the umeng blog server fail!!");
        }
        [_activityIndicatorView stopAnimating];
    }];

    [super viewDidLoad];
    self.title = @"分享";
    self.tabBarItem.image = [UIImage imageNamed:@"UMS_share"];
    
     // Do any additional setup after loading the view from its nib.
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    /*
     如果你用分享列表样式1并且想要支持旋转的话，只能在点击分享调用后下面的写法
     UMSocialIconActionSheet *iconActionSheet = [[UMSocialControllerService defaultControllerService] getSocialIconActionSheetInController:self];
     iconActionSheet.tag = 1000;
     //因为demo，有tabBarController,如果你有navigationController的话用self.navigationController,否则用self.view
     [iconActionSheet showInView:self.tabBarController.view];
     
     并且在这里调用下面的方法
     //self.tabBarController.view和上面的self.tabBarController.view对应
     UIView * iconActionSheet = [self.tabBarController.view viewWithTag:1000];
     [iconActionSheet setNeedsDisplay];
     */
    
    _shareButton1.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/5);
    _shareButton3.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/5 *3);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
