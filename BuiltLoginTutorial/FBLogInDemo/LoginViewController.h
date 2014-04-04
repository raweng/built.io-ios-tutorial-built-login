//
//  LoginViewController.h
//  FBLogInDemo
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <BuiltIO/BuiltIO.h>

@interface LoginViewController : UIViewController<BuiltUILoginDelegate,BuiltUITwitterAppSettingDelegate,BuiltUIGoogleAppSettingDelegate,UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UIButton *loginBtn;
@end
