//
//  MBaseViewController.m
//  
//
//  Created by Zhengyidong(mrzhengyidong@sina.com) on 13-12-9.
//  
//

#import "MBaseViewController.h"


@interface MBaseViewController ()

@end

@implementation MBaseViewController

@synthesize table;
@synthesize originFrame;
@synthesize contentView;
@synthesize curTextField;
@synthesize curOrientation;
@synthesize frame_width;
@synthesize frame_height;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        curOrientation = UIInterfaceOrientationPortrait;
        frame_height = SCREEN_HEIGHT;
        frame_width = SCREEN_WIDTH;
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated
{
    
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
#endif
}

-(void)setOrientation:(UIInterfaceOrientation)orientation
{
    curOrientation = orientation;
    
    if (curOrientation == UIInterfaceOrientationPortrait)
    {
        frame_width = SCREEN_WIDTH;
        frame_height = SCREEN_HEIGHT;
    }
    if (curOrientation == UIInterfaceOrientationLandscapeRight)
    {
        frame_width = SCREEN_HEIGHT;
        frame_height = SCREEN_WIDTH;
        
        if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPhone)
        {
            frame_height -= 14;
        }
    }
}

-(void)reloadData
{
    if (table != nil)
    {
        [table reloadData];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name: UIKeyboardWillChangeFrameNotification object:nil];
    }
#endif
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x393a3a)] forBarMetrics:UIBarMetricsDefault];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:20], NSFontAttributeName, nil]];
    
    self.view.backgroundColor = UIColorFromRGB(0xecf0f1);
    
    [self.navigationController.toolbar setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0xe2e7ea)] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    
    self.view.frame = CGRectMake(0, 0, frame_width, frame_height);
    contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame_width, frame_height)];
    contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentView];
    
    originFrame = contentView.frame;
}

-(void)setupTableView:(CGRect)frame
{
    table = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    
    [table setDelegate:self];
    [table setDataSource:self];
    [self.contentView addSubview:table];
    
    [table setBackgroundColor:[UIColor clearColor]];
}

-(void)setupRightMenuButton:(NSString *)title
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if(curOrientation == UIInterfaceOrientationPortrait)
    {
        rightButton.frame = CGRectMake(0.0, 0.0, 60, 44);
    }
    if (curOrientation == UIInterfaceOrientationLandscapeRight)
    {
        rightButton.frame = CGRectMake(0.0, 0.0, 60, 36);
    }
    [rightButton setBackgroundImage:rightnavigationitem forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [rightButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setExclusiveTouch:YES];
    [rightButton addTarget:self action:@selector(rightButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton addTarget:self action:@selector(dismissKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    rightBarButtonItem.style = UIBarButtonItemStylePlain;
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem animated:YES];
}

-(void)setupLeftMenuButton
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if(curOrientation == UIInterfaceOrientationPortrait)
    {
        backButton.frame = CGRectMake(0.0, 0.0, 60, 44);
    }
    if (curOrientation == UIInterfaceOrientationLandscapeRight)
    {
        backButton.frame = CGRectMake(0.0, 0.0, 60, 36);
    }

    [backButton setBackgroundImage:leftnavigationitem forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [backButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [backButton setTitle:NSLocalizedString(@"back", nil) forState:UIControlStateNormal];
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [backButton setExclusiveTouch:YES];
    [backButton addTarget:self action:@selector(backButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [backButton addTarget:self action:@selector(dismissKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    leftBarButtonItem.style = UIBarButtonItemStylePlain;
    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem animated:YES];
}

-(void)backButtonPress:(id)sender
{
    if (self.navigationController.viewControllers.count == 1)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Button Handlers
-(void)rightButtonPress:(id)sender
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//该方法为点击虚拟键盘Return，要调用的代理方法：隐藏虚拟键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell_%d_%d",indexPath.section, indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (curTextField != nil)
    {
        [curTextField resignFirstResponder];
    }
}

- (void)dismissKeyboard:(id)sender {
    if (curTextField != nil)
    {
        [curTextField resignFirstResponder];
    }
}

- (void)keyboardWillChange:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGRect frame = curTextField.frame;
    
    int distance = (frame.origin.y + frame.size.height) - (originFrame.size.height - kbSize.height);
    
    if (self.navigationController != nil)
    {
        distance += 64;
    }
    else
    {
        if (!OSVersionIsAtLeastiOS7())
        {
            distance += 20;
        }
    }
    
    NSLog(@"%d", distance);
    
    [UIView animateWithDuration:0.5f animations:^
     {
         if (distance > 0)
         {
             self.contentView.frame = CGRectMake(originFrame.origin.x, originFrame.origin.y-distance, originFrame.size.width, originFrame.size.height);
         }
         else
         {
             self.contentView.frame = originFrame;
         }
     }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    curTextField = textField;
    CGRect frame = textField.frame;
    CGFloat kbHeight = 216.0f;
    int distance = (frame.origin.y + frame.size.height) - (originFrame.size.height - kbHeight);
    
    if (self.navigationController != nil)
    {
        distance += 64;
    }
    else
    {
        if (!OSVersionIsAtLeastiOS7())
        {
            distance += 20;
        }
    }

    
    NSLog(@"%0.0f %d %0.0f", frame.origin.y + frame.size.height, distance, SCREEN_HEIGHT - kbHeight);
    
    [UIView animateWithDuration:0.5f animations:^
     {
         if (distance > 0)
         {
             self.contentView.frame = CGRectMake(originFrame.origin.x, originFrame.origin.y-distance, originFrame.size.width, originFrame.size.height);
         }
         else
         {
             self.contentView.frame = originFrame;
         }
     }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    curTextField  = nil;
    [UIView animateWithDuration:0.5f animations:^
     {
         self.contentView.frame = originFrame;
     }];
}

-(BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return curOrientation;
}


@end
