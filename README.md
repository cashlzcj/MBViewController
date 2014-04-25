MBViewController
================

iOS ViewController that can auto adapt to the screen size, show/hide keyboard and config the navigationbar

使用方式：

1.
MBViewController *viewcontroller = [[MBViewController alloc] init];

MBaseNavViewController *navviewcontroller = [[MBaseNavViewController alloc] initWithRootViewController:viewcontroller];

[[UIApplication sharedApplication] delegate].window.rootViewController = navviewcontroller;


2.

MBViewController *viewcontroller = [[MBViewController alloc] init];

MBaseNavViewController *navviewcontroller = [[MBaseNavViewController alloc]initWithRootViewController:viewcontroller];

[self.navigationController presentViewController:navviewcontroller animated:YES completion:nil];

3.

MBViewController *viewcontroller = [[MBViewController alloc] init];

[self.navigationController pushViewController:viewcontroller animated:YES];


其中第1，2种方式可以通过下面的方式来改变屏幕的方向</br>

[viewcontroller setOrientation:UIInterfaceOrientationLandscapeRight];


其他接口及功能描述：

-(void)setupTableView:(CGRect)frame //创建一个tableview

-(void)setupRightMenuButton:(NSString *)title //设置导航栏右侧按钮，按钮文字显示为title

-(void)setupLeftMenuButton //设置导航栏左侧按钮

-(void)rightButtonPress:(id)sender //设置导航栏右侧按钮功能

