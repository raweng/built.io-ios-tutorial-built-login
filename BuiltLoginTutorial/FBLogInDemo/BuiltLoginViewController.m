//
//  BuiltLoginViewController.m
//  FBLogInDemo
//


#import "BuiltLoginViewController.h"
#import <BuiltIO/BuiltIO.h>

@interface BuiltLoginViewController ()

@end

@implementation BuiltLoginViewController

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
    
	// Do any additional setup after loading the view.
    BuiltUILoginController *loginView = [[BuiltUILoginController alloc]initWithNibName:nil bundle:nil];
//    [loginView.view setFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:loginView.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
