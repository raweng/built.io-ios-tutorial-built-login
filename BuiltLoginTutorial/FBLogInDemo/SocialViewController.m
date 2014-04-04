//
//  SocialViewController.m
//  FBLogInDemo
//
//  Created by Viresh Madabhavi on 27/3/14.
//  Copyright (c) 2014 raweng. All rights reserved.
//

#import "SocialViewController.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface SocialViewController ()
@property (nonatomic, strong) UIButton *facebookButton;
@property (nonatomic, assign) BOOL isFBLogged;
@end

@implementation SocialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //set delegate for twitter and google accounts
        self.twitterAppSettingDelegate = self;
        self.googleAppSettingDelegate = self;
        self.delegate = self;
        //the login fields which are to be displayed
        self.fields = BuiltLoginFieldTwitter|BuiltLoginFieldGoogle;
        self.shouldHandleLoadingHUD = YES;
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.facebookButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.facebookButton setFrame:CGRectMake(0, 0, 150, 40)];
    [self.facebookButton setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)];
    
    UIImage *originalImage = [UIImage imageWithContentsOfFile:[[self frameworkBundle] pathForResource:@"form_button" ofType:@"png"]];
    
    UIImage *stretchableImage = [originalImage stretchableImageWithLeftCapWidth:6 topCapHeight:6];
    
    [self.facebookButton setBackgroundImage:stretchableImage forState:UIControlStateNormal];
    
    [self.facebookButton setTitle:NSLocalizedString(@"Facebook",nil) forState:UIControlStateNormal];
    
    [self.facebookButton addTarget:self action:@selector(authenticateWithFacebook:) forControlEvents:UIControlEventTouchUpInside];
    
    self.facebookButton.titleLabel.shadowColor = [UIColor whiteColor];
    
    [self.view addSubview:self.facebookButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSBundle *)frameworkBundle {
    
    static NSBundle* frameworkBundle = nil;
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        NSString* mainBundlePath = [[NSBundle mainBundle] resourcePath];
        
        NSString* frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"BuiltIO.bundle"];
        
        frameworkBundle = [NSBundle bundleWithPath:frameworkBundlePath];
        
    });
    
    return frameworkBundle;
    
}

-(void)loginSuccessWithUser:(BuiltUser *)user{
    NSLog(@"loginSuccessWithUser %@",user);
}

-(void)loginFailedWithError:(NSError *)error{
    
}

#pragma mark
#pragma mark GoogleAppSettingDelegate
//For Google App Client ID to authenticate from Google
-(NSString *)googleAppClientID{
    //Put client_id here
    return @"568588508670.apps.googleusercontent.com";
}

//For Google App Client Secret to authenticate from Google
-(NSString *)googleAppClientSecret{
    //Put secret here
    return @"YNASO2MDS17U58rT7Hm12l7Z";
}

#pragma mark
#pragma mark TwitterAppSettingDelegate

-(NSString *)consumerKey{
    //Put twitter consumer_key here
    return @"6HcjyZmhuzROqGxSzjH4Q";
}

-(NSString *)consumerSecret{
    //Put twitter consumer_secret here
    return @"pn2M82Cp4SB091SpanVJf8yTZDUgGtcSJhz4jCD450";
}

-(void)didClickTwitterButton:(NSError *)error{
    NSLog(@"didClickTwitterButton %@",error);
    
    UIAlertView *twitterErrorAlert = [[UIAlertView alloc]initWithTitle:@"Twitter Error" message:[[error userInfo] objectForKey:@"error"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [twitterErrorAlert show];
}

#pragma mark
#pragma mark authenticate with facebook
-(void)authenticateWithFacebook:(id)sender{
    AppDelegate *delegate = [AppDelegate sharedAppDelegate];
    
    // Check if user has logged in with facebook
    //
    //   BuiltUser is a special class that allows adding the users functionality to our application.It features such as registration, logging in, logging out live here.
    //Gets user session stored on disk.
    BuiltUser *user = [BuiltUser getSession];
    if (user != nil) {
        NSDictionary *facebookData = [[user objectForKey:@"auth_data"] objectForKey:@"facebook"];
        if (facebookData != nil) {
            self.isFBLogged = YES;
        }else{
            self.isFBLogged = NO;
        }
    }else{
        self.isFBLogged = NO;
    }
    
    // Check if user is logged in with facebook
    if (!self.isFBLogged) {
        [delegate openSession:^(FBSession *session) {
            
            if (session) {
                BuiltUser *builtUser = [BuiltUser user];
                [builtUser loginWithFacebookAccessToken:[delegate.session accessTokenData].accessToken onSuccess:^{
                    [builtUser saveSession];
                    [self callForDetailView];
                    
                } onError:^(NSError *error) {
                    UIAlertView *fbErrorAlert = [[UIAlertView alloc]initWithTitle:@"Facebook Login Error" message:@"Please try again in a short while..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [fbErrorAlert show];
                }];
            }else{
                UIAlertView *fbErrorAlert = [[UIAlertView alloc]initWithTitle:@"Facebook Login Error" message:@"Please try again in a short while..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [fbErrorAlert show];
            }
            
        } onError:^(NSError *error) {
            UIAlertView *fbErrorAlert = [[UIAlertView alloc]initWithTitle:@"Login Error" message:@"Please try again in a bit." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [fbErrorAlert show];
            
        }];
    }else{
        [self callForDetailView];
    }
}

-(void)callForDetailView{
    DetailViewController *detailViewcontroller = [[DetailViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:detailViewcontroller animated:YES];
}

@end
