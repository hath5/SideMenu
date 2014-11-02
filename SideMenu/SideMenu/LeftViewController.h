//
//  LeftViewController.h
//  SideMenu
//
//  Created by Tran Hoang Ha on 10/31/14.
//  Copyright (c) 2014 Tran Hoang Ha. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LeftViewControllerBlock)(NSIndexPath *indexPath);

@interface LeftViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, weak) IBOutlet UITableView *tableViewLeftMenu;
@property(copy) LeftViewControllerBlock leftMenuBlock;
+(void)showMenuWithView:(UIView*)view
     withViewController:(UIViewController*)viewController
               withDone:(LeftViewControllerBlock)doneBlock;
+(void)hideMenu;
@end
