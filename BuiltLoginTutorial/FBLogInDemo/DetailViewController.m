//
//  DetailViewController.m
//  FBLogInDemo
//


#import "DetailViewController.h"
#import "AppDelegate.h"
#import <BuiltIO/BuiltIO.h>
#define LABEL_WIDTH 300
#define LABEL_HEIGHT 50

@interface DetailViewController (){
    UILabel *userName;
    UILabel *userNameTitle;
}

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    //Gets the currently logged in user from disk and returns an instance of it
    BuiltUser *currentUser = [BuiltUser currentUser];
    [self initialiseView:currentUser];
    
}

-(void)initialiseView:(BuiltUser*)user{
    
    userNameTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, LABEL_WIDTH, LABEL_HEIGHT)];
    [userNameTitle setText:@"Logged User :"];
    [userNameTitle setTextAlignment:NSTextAlignmentCenter];
    [userNameTitle setBackgroundColor:[UIColor clearColor]];
    [userNameTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:userNameTitle];
    
    userName = [[UILabel alloc] init];
    [userName setText:[NSString stringWithFormat:@"%@ %@",user.firstName,user.lastName]];
    [userName setTextAlignment:NSTextAlignmentCenter];
    [userName setBackgroundColor:[UIColor clearColor]];
    [userName setTextColor:[UIColor blackColor]];
    [userName setFrame:CGRectMake(15, 180, LABEL_WIDTH,  LABEL_HEIGHT)];
    [self.view addSubview:userName];
    
    BOOL isDataNull = NO;
    NSDictionary *authDataDict = [user objectForKey:@"auth_data"];
    
    isDataNull = authDataDict == nil ? true : false;
    
    if (!isDataNull) {
        NSDictionary *facebookDict = [authDataDict objectForKey:@"facebook"];
        isDataNull = facebookDict == nil ? true : false;
    }

    if (!isDataNull) {
        NSDictionary *userProfile = [[authDataDict objectForKey:@"facebook"] objectForKey:@"user_profile"];
        userName.text = [NSString stringWithFormat:@"%@ %@",[userProfile objectForKey:@"first_name"],[userProfile objectForKey:@"last_name"]];
    }
    
    UIButton *logutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [logutButton addTarget:self
               action:@selector(logoutButtonTapped)
     forControlEvents:UIControlEventTouchDown];
    [logutButton setTitle:@"Show View" forState:UIControlStateNormal];
    logutButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self action:@selector(logoutButtonTapped)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)logoutButtonTapped{
    //Close session of current user
    AppDelegate *appDelegate = [AppDelegate sharedAppDelegate];
    
    // An application may get or set the current active session
    appDelegate.session = [[FBSession alloc]init];
    
    //clears any persisted cache related to the session.
    [FBSession.activeSession closeAndClearTokenInformation];
    
    //Closes the local in-memory session object,
    [[AppDelegate sharedAppDelegate].session close];
    [FBSession setActiveSession:nil];
    
    BuiltUser *user = [BuiltUser currentUser];
    
    //Clears User Session
    [user clearSession];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
