//
//  AppDelegate.m
//  
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "LoginViewController.h"

@implementation AppDelegate

// ****************************************************************************
// BuiltLogin app demonstrates the login functionality in Built.io Backend
// Login
// ****************************************************************************


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Sets the api key and application uid of your application
    self.builtApplication = [Built applicationWithAPIKey:@"blt2ff1c94fb4d8c7df"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.navigationController = [[UINavigationController alloc]init];
    
    BuiltUser *user = [self.builtApplication currentUser];
    if (!user.uid) {
        LoginViewController *bltLoginController = [[LoginViewController alloc]initWithNibName:nil bundle:nil];

        bltLoginController.builtApplication = self.builtApplication;
        
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

+ (NSBundle *)builtFrameworkBundle {
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
