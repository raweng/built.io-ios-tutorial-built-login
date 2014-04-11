//
//  AppDelegate.m
//  FBLogInDemo
//

#import "AppDelegate.h"
#import "Constant.h"
#import <BuiltIO/BuiltIO.h>
#import "BuiltLoginController.h"

@interface AppDelegate()<BuiltUILoginDelegate>

@end

@implementation AppDelegate

// ****************************************************************************
// BuiltLogin app demonstrates the login functionality in built.io
// Login
// ****************************************************************************


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Sets the api key and application uid of your application
    [Built initializeWithApiKey:kAPI_KEY andUid:kAPP_UID];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self showLoginView];

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
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

- (void)showLoginView{
    BuiltLoginController *bltLoginController = [[BuiltLoginController alloc]initWithNibName:nil bundle:nil];
    bltLoginController.fields = BuiltLoginFieldLogin|BuiltLoginFieldUsernameAndPassword;
    bltLoginController.delegate = self;
    
    self.window.rootViewController = bltLoginController;
}

#pragma mark - BuiltUILoginDelegate
-(void)loginSuccessWithUser:(BuiltUser *)user{
    NSLog(@"loginSuccessWithUser %@",user);
}

-(void)loginFailedWithError:(NSError *)error{
    NSLog(@"loginFailedWithError %@",error);
}

@end
