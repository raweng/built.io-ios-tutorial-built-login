//
//  HomeViewController.m
//  BuiltLogin
//
//  Created by Sameer on 12/04/14.
//  Copyright (c) 2014 raweng. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor lightGrayColor];
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"builtio-logo.png"]];
    
    [imageView setCenter:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)];
    
    [self.view addSubview:imageView];
    
    UIButton *button = [[UIButton alloc]init];
    UIImage *originalImage = [UIImage imageWithContentsOfFile:[[AppDelegate frameworkBundle] pathForResource:@"form_button" ofType:@"png"]];
    UIImage *stretchableImage = [originalImage stretchableImageWithLeftCapWidth:6 topCapHeight:6];
    [button setBackgroundImage:stretchableImage forState:UIControlStateNormal];
    button.titleLabel.shadowColor = [UIColor whiteColor];
    button.titleLabel.textColor = [UIColor blueColor];
    
    
    [button setTitle:@"Logout" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 150, 30)];
    [button setCenter:CGPointMake(self.view.frame.size.width / 2, CGRectGetMaxY(imageView.frame) + 30)];
    [button addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
	// Do any additional setup after loading the view.
}

- (void)logout:(id)sender{
    // Gets the saved BuiltUser object and performs logout
    BuiltUser *user = [BuiltUser getSession];
    [user clearSession];
    
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    LoginViewController* loginViewController = [[LoginViewController alloc]initWithNibName:nil bundle:nil];
    
    if (![[[[AppDelegate sharedAppDelegate].navigationController viewControllers] objectAtIndex:0] isKindOfClass:[LoginViewController class]]) {
        
        [vcs replaceObjectAtIndex:0 withObject:loginViewController];
        [[AppDelegate sharedAppDelegate].navigationController setViewControllers:vcs animated:NO];
        [AppDelegate sharedAppDelegate].window.rootViewController = [AppDelegate sharedAppDelegate].navigationController;
    }else{
        
        [vcs insertObject:loginViewController atIndex:0];
        [[AppDelegate sharedAppDelegate].navigationController setViewControllers:vcs animated:NO];
        UIViewController *viewController = [[AppDelegate sharedAppDelegate].navigationController.viewControllers objectAtIndex:0];
        [[AppDelegate sharedAppDelegate].navigationController popToViewController:viewController animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
