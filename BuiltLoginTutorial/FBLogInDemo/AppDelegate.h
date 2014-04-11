//
//  AppDelegate.h
//  FBLogInDemo


#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{

}

@property (strong, nonatomic) UIWindow *window;

- (void)showLoginView;

+ (AppDelegate *)sharedAppDelegate;

@end
