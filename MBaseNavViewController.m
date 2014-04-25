//
//  MBaseNavViewController.m
//  
//
//  Created by Zhengyidong(mrzhengyidong@sina.com) on 13-12-9.
//  
//

#import "MBaseNavViewController.h"

@interface MBaseNavViewController ()

@end

@implementation MBaseNavViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate {
    return [[self.viewControllers lastObject] shouldAutorotate];
}

//-(NSUInteger)supportedInterfaceOrientations {
//    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
//}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

@end
