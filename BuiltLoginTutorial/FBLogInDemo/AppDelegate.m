//
//  AppDelegate.m
//  FBLogInDemo
//

#import "AppDelegate.h"
#import "Constant.h"
#import "HomeViewController.h"
#import "LoginViewController.h"

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
    
    self.navigationController = [[UINavigationController alloc]init];
    
    BuiltUser *user = [BuiltUser getSession];
    if (!user) {
        LoginViewController *bltLoginController = [[LoginViewController alloc]initWithNibName:nil bundle:nil];
//        bltLoginController.fields = BuiltLoginFieldLogin|BuiltLoginFieldUsernameAndPassword;
//        bltLoginController.delegate = self;
        
        [self.navigationController setViewControllers:[NSArray arrayWithObjects:bltLoginController, nil]];
        
        self.window.rootViewController = self.navigationController;
    }else{
        HomeViewController *homeVC = [[HomeViewController alloc]initWithNibName:nil bundle:nil];
        [self.navigationController setViewControllers:[NSArray arrayWithObjects:homeVC, nil]];
        
        self.window.rootViewController = homeVC;
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

+(AppDelegate *)sharedAppDelegate{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

+ (NSBundle *)frameworkBundle {
    static NSBundle* frameworkBundle = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString* mainBundlePath = [[NSBundle mainBundle] resourcePath];
        NSString* frameworkBundlePath = [mainBundlePath stringByAppendingPathComponent:@"BuiltIO.bundle"];
        frameworkBundle = [NSBundle bundleWithPath:frameworkBundlePath];
    });
    return frameworkBundle;
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

@end
