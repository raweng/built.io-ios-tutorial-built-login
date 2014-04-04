//
//  AppDelegate.h
//  FBLogInDemo


#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@class LoginViewController;
@class DetailViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    LoginViewController *loginViewController;
    DetailViewController *detailViewController;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) FBSession *session;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic) BOOL  isLogged;

- (void)openSession:(void (^) (FBSession *session))successBlock onError:(void (^) (NSError *error))errorBlock;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;
- (void)showLoginView;

+(AppDelegate *)sharedAppDelegate;
@end
