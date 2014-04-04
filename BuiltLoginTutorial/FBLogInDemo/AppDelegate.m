//
//  AppDelegate.m
//  FBLogInDemo
//

#import "AppDelegate.h"
#import "Constant.h"
#import "LoginViewController.h"
#import <BuiltIO/BuiltIO.h>
#import "DetailViewController.h"

@implementation AppDelegate
@synthesize session,navigationController,isLogged;

// ****************************************************************************
// Login Demo app gives varity of Sign Up and Login with Built.io
// Also have facility to get Login with Facebook,Google and Twitter id
// ****************************************************************************


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Sets the api key and application uid of your application
    [Built initializeWithApiKey:kAppAPI_key andUid:cAppUID];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // ****************************************************************************
    // Fill in with your Built and Facebook credentials. Don't forget to add your
    // Facebook id in Info.plist:
    // Requires Facebook API key
    // ****************************************************************************
    
    loginViewController = [[LoginViewController alloc] initWithNibName:nil bundle:nil];
    [self showLoginView];
    
    // Initiate FBSession with API key with tokenCacheStrategy
    self.session = [[FBSession alloc]initWithAppID:kFBAPIKEY permissions:nil urlSchemeSuffix:nil tokenCacheStrategy:[[FBSessionTokenCachingStrategy alloc] initWithUserDefaultTokenInformationKeyName:@"FBAccessTokenInformationKey"]];
    
    // An application may get or set the current active session
    [FBSession setActiveSession:self.session];
    isLogged = YES;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

+(AppDelegate *)sharedAppDelegate{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (void)applicationWillResignActive:(UIApplication *)application
{

}

- (void)applicationDidEnterBackground:(UIApplication *)application
{

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppCall handleDidBecomeActiveWithSession:self.session];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self.session close];
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    //For the proper processing of responses during interaction with the native Facebook app
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication withSession:self.session];
}

- (void)openSession:(void (^) (FBSession *session))successBlock onError:(void (^) (NSError *error))errorBlock{

    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    
    if (!appDelegate.session.isOpen) {
        
        //It is required any single permission request
        appDelegate.session = [[FBSession alloc]initWithAppID:kFBAPIKEY permissions:[NSArray arrayWithObjects:@"status_update", @"publish_stream", nil] urlSchemeSuffix:nil tokenCacheStrategy:[[FBSessionTokenCachingStrategy alloc] initWithUserDefaultTokenInformationKeyName:@"FBAccessTokenInformationKey"]];
    }
    //Opens a session for the Facebook.
    [appDelegate.session openWithCompletionHandler:^(FBSession *session1, FBSessionState status, NSError *error) {
        if (!error && session1 && status != FBSessionStateClosedLoginFailed) {
            successBlock(session1);
        }else{
            errorBlock(error);
        }
    }];
}

- (void)showLoginView{
    self.navigationController = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    self.window.rootViewController = self.navigationController;
}

- (void)showDetailView{
    [[self window]setRootViewController:detailViewController];
    self.window.rootViewController = self.navigationController;
}

@end
