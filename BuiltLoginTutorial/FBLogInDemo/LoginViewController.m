//
//  LoginViewController.m
//  FBLogInDemo
//


#import "LoginViewController.h"
#import <Accounts/Accounts.h>
#import "AppDelegate.h"
#import "DetailViewController.h"
#import "BuiltLoginViewController.h"
#import "SocialViewController.h"

@interface LoginViewController (){
    BOOL isFBLogged;
    BOOL isBuiltLogged;
    BuiltUser *builtUser;
    UITableView *logintableView;
    NSArray * tableData;
    BuiltUILoginController *loginView;
}
@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccount *fbAccount;

@end

@implementation LoginViewController
@synthesize accountStore,fbAccount;
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
    
    //The ACAccountStore class provides an interface for accessing, manipulating, and storing accounts.
    self.accountStore = [[ACAccountStore alloc]init];
    self.navigationItem.title = @"Login Demo With Built.io";
    logintableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    logintableView.delegate = self;
    logintableView.dataSource = self;
    [self.view addSubview:logintableView];

    tableData = [NSArray arrayWithObjects:@"Login with Built.io",@"Login with Social",nil];
}

#pragma mark
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    [cell.textLabel setText:[tableData objectAtIndex:indexPath.row]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if (indexPath.row == 0 ) {
        [self loginWithBuilt];
    }else if (indexPath.row == 1){
        [self loginViewShowingLoggedInUser];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 63.0f;
}

- (void)loginViewShowingLoggedInUser{
    
    SocialViewController *socialVC = [[SocialViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:socialVC animated:YES];
}

-(void)loginWithBuilt{
    
    // Check if user is Sign in with "Built.io"
    if (!isBuiltLogged) {
        
        //Initiate BuiltUILoginController to Login with Built.io ,Google and Twitter account
        loginView = [[BuiltUILoginController alloc]initWithNibName:nil bundle:nil];
//        [loginView.view setFrame:CGRectMake(10, 50, self.view.frame.size.width, self.view.frame.size.height - 50)];
        loginView.delegate = self;
        
        // Selection of UI feilds needs to be displayed on Login view
        loginView.fields = BuiltLoginFieldSignUp|BuiltLoginFieldUsernameAndPassword|BuiltLoginFieldLogin|BuiltLoginFieldDismiss;
        
//        loginView.fields =  BuiltLoginFieldTwitter;
        [loginView.dismissButton addTarget:loginView.dismissButton action:@selector(cancelTapped) forControlEvents:UIControlEventTouchDown];

        // Set delegates  for twitter and google sign in
        [loginView setTwitterAppSettingDelegate:self];
        [loginView setGoogleAppSettingDelegate:self];
        loginView.shouldHandleLoadingHUD = YES;
        [[AppDelegate sharedAppDelegate].navigationController pushViewController:loginView animated:YES];
    }
}

-(void)cancelTapped{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)callForDetailView{
    DetailViewController *detailViewcontroller = [[DetailViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:detailViewcontroller animated:YES];
}

//Invoked when Login is successful.
- (void)loginSuccessWithUser:(BuiltUser *)user{
    //Save user on disk and get user info
    [user saveSession];
    
    NSLog(@"loginSuccessWithUser %@",user);
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//Invoked when Login is failed.
-(void)loginFailedWithError:(NSError *)error{
    NSLog(@"loginFailedWithError %@",error);
}

#pragma mark
#pragma mark GoogleAppSettingDelegate

//For Google App Client ID to authenticate from Google
-(NSString *)googleAppClientID{
    //Put client_id here
    return @"568588508670.apps.googleusercontent.com";
}

//For Google App Client Secret to authenticate from Google
-(NSString *)googleAppClientSecret{
    //Put secret here
    return @"YNASO2MDS17U58rT7Hm12l7Z";
}

#pragma mark
#pragma mark TwitterAppSettingDelegate

-(NSString *)consumerKey{
    //Put twitter consumer_key here
    return @"6HcjyZmhuzROqGxSzjH4Q";
}

-(NSString *)consumerSecret{
    //Put twitter consumer_secret here
    return @"pn2M82Cp4SB091SpanVJf8yTZDUgGtcSJhz4jCD450";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
