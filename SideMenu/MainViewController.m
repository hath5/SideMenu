//
//  MainViewController.m
//  SideMenu
//
//  Created by Tran Hoang Ha on 10/31/14.
//  Copyright (c) 2014 Tran Hoang Ha. All rights reserved.
//

#import "MainViewController.h"
#import "FirstViewController.h"
#import "LeftViewController.h"
#import "SecondViewController.h"

@interface MainViewController ()<UINavigationControllerDelegate>
{
    UINavigationController *navigationController;
    FirstViewController *firstVC;
    SecondViewController *secondVC;
    BOOL isShowMenu;
}
@end

@implementation MainViewController

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
    // Do any additional setup after loading the view from its nib.
    firstVC = [[FirstViewController alloc] init];
    navigationController = [[UINavigationController alloc]initWithRootViewController:firstVC];
    navigationController.delegate = self;
    navigationController.navigationBar.translucent = NO;
    [navigationController.view setFrame:self.view.frame];
    
    [self.view addSubview:navigationController.view];
    [self addChildViewController:navigationController];
    
    [self showMenuButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showMenuButton
{
    UIBarButtonItem* leftBarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_menu.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];
    [navigationController.topViewController.navigationItem setLeftBarButtonItem:leftBarItem];
}

- (void)showMenu
{
    if (isShowMenu) {
        [self hideMenu];
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = navigationController.view.frame;
        rect.origin.x = self.view.bounds.size.width - 50;
        [navigationController.view setFrame:rect];
    }];
    isShowMenu = YES;
    [LeftViewController showMenuWithView:_centerView withViewController:self withDone:^(NSIndexPath *indexPath) {
        [self hideMenu];
        if (indexPath.row == 0) {
            [self showFirstViewController];
        }
        if (indexPath.row == 1) {
            [self showSecondViewController];
        }
    }];
}

- (void)hideMenu
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rectCurrentView = navigationController.topViewController.view.frame;
        rectCurrentView.origin.x = 0;
        [navigationController.topViewController.view setFrame:rectCurrentView];
        
        CGRect rect = navigationController.view.frame;
        rect.origin.x = 0;
        [navigationController.view setFrame:rect];
    } completion:^(BOOL finished) {
        if (finished) {
            [LeftViewController hideMenu];
            isShowMenu = NO;
        }
    }];
}

- (void)showFirstViewController
{
    NSLog(@"showFirstViewController");
    firstVC = [[FirstViewController alloc]initWithNibName:@"FirstViewController" bundle:nil];
    [navigationController setViewControllers:[NSArray arrayWithObject:firstVC]];
    [self showMenuButton];
}

- (void)showSecondViewController
{
    NSLog(@"showSecondViewController");
    secondVC = [[SecondViewController alloc]initWithNibName:@"SecondViewController" bundle:nil];
    [navigationController setViewControllers:[NSArray arrayWithObject:secondVC]];
    [self showMenuButton];
}
@end
