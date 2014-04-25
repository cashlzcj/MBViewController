MBViewController
================

iOS ViewController that can auto adapt to the screen size, show/hide keyboard and config the navigationbar

使用方式：</br>
1.</br>
MBViewController *viewcontroller = [[MBViewController alloc] init];</br>
MBaseNavViewController *navviewcontroller = [[MBaseNavViewController alloc] initWithRootViewController:viewcontroller];</br>
[[UIApplication sharedApplication] delegate].window.rootViewController = navviewcontroller;</br>

2.</br>
MBViewController *viewcontroller = [[MBViewController alloc] init];</br>
MBaseNavViewController *navviewcontroller = [[MBaseNavViewController alloc]initWithRootViewController:viewcontroller];</br>
[self.navigationController presentViewController:navviewcontroller animated:YES completion:nil];</br>
3.</br>
MBViewController *viewcontroller = [[MBViewController alloc] init];</br>
[self.navigationController pushViewController:viewcontroller animated:YES];</br>

其中第1，2种方式可以通过下面的方式来改变屏幕的方向</br>
[viewcontroller setOrientation:UIInterfaceOrientationLandscapeRight];</br>

其他接口及功能描述：</br>
-(void)setupTableView:(CGRect)frame //创建一个tableview</br>
-(void)setupRightMenuButton:(NSString *)title //设置导航栏右侧按钮，按钮文字显示为title</br>
-(void)setupLeftMenuButton //设置导航栏左侧按钮</br>
-(void)rightButtonPress:(id)sender //设置导航栏右侧按钮功能</br>
