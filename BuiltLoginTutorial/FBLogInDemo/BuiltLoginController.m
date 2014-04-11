//
//  BuiltLoginController.m
//  BuiltLogin

#import "BuiltLoginController.h"

@interface BuiltLoginController ()

@end

@implementation BuiltLoginController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.fields = BuiltLoginFieldDefault;
        self.delegate = self;
        // Custom initialization
    }
    return self;
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
}

-(void)loginFailedWithError:(NSError *)error{
    NSLog(@"loginFailedWithError %@",error);
}

@end
