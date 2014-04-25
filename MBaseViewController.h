//
//  MBaseViewController.h
//  
//
//  Created by Zhengyidong(mrzhengyidong@sina.com) on 13-12-9.
//  
//

#import <UIKit/UIKit.h>

#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

#define leftnavigationitem [[UIImage imageNamed:@"leftnavigationitem"] stretchableImageWithLeftCapWidth:20 topCapHeight:0]
#define rightnavigationitem [[UIImage imageNamed:@"rightnavigationitem"] stretchableImageWithLeftCapWidth:20 topCapHeight:0]

@interface MBaseViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,IZValueSelectorViewDataSource,IZValueSelectorViewDelegate>

@property (nonatomic,strong)UITableView *table;

@property (nonatomic)UIInterfaceOrientation curOrientation;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UITextField *curTextField;
@property (nonatomic) CGRect originFrame;

@property (nonatomic) CGFloat frame_width;
@property (nonatomic) CGFloat frame_height;

-(void)setupRightMenuButton:(NSString *)title;
-(void)setupLeftMenuButton;
-(void)setupTableView:(CGRect)frame;

-(void)reloadData;

-(void)setOrientation:(UIInterfaceOrientation)orientation;

- (void)dismissKeyboard:(id)sender;

@end
