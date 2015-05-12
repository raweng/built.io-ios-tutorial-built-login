//
//  AppDelegate.h
//  


#import <UIKit/UIKit.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>{

}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) BuiltApplication *builtApplication;

+ (AppDelegate *)sharedAppDelegate;

+ (NSBundle *)builtFrameworkBundle;

@end
