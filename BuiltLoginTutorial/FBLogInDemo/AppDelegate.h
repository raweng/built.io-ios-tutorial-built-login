//
//  AppDelegate.h
//  FBLogInDemo


#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;

+ (AppDelegate *)sharedAppDelegate;

+ (NSBundle *)frameworkBundle;

@end
