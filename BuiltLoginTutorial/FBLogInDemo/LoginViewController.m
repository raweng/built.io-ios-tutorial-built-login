//
//  LoginViewController.m
//  BuiltLogin
//
//  Created by Sameer on 14/04/14.
//  Copyright (c) 2014 raweng. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.fields = BuiltLoginFieldLogin|BuiltLoginFieldUsernameAndPassword;
        self.delegate = self;
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BuiltUILoginDelegate

-(void)loginSuccessWithUser:(BuiltUser *)user{
    NSLog(@"loginSuccessWithUser %@",user);
    
    [user saveSession];
    
    HomeViewController *homeVC = [[HomeViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:homeVC animated:YES];
}

-(void)loginFailedWithError:(NSError *)error{
    NSLog(@"loginFailedWithError %@",error);
}

@end
