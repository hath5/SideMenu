//
//  LeftViewController.m
//  SideMenu
//
//  Created by Tran Hoang Ha on 10/31/14.
//  Copyright (c) 2014 Tran Hoang Ha. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()
{
    NSMutableArray *arrayLeftMenuData;
}
@end

@implementation LeftViewController

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
    arrayLeftMenuData = [[NSMutableArray alloc] initWithObjects:@"First", @"Second", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static LeftViewController *leftMenu;
+(void)showMenuWithView:(UIView *)view
     withViewController:(UIViewController *)viewController
               withDone:(LeftViewControllerBlock)doneBlock
{
    if (!leftMenu) {
        leftMenu = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
        leftMenu.leftMenuBlock = doneBlock;
        [leftMenu.view setFrame:view.frame];
        [view addSubview:leftMenu.view];
        [viewController addChildViewController:leftMenu];
    }
}
+(void)hideMenu
{
    [leftMenu.view removeFromSuperview];
    [leftMenu removeFromParentViewController];
    leftMenu = nil;
}

#pragma mark - TableViewDelegate, DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayLeftMenuData.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [arrayLeftMenuData objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _leftMenuBlock(indexPath);
}
@end
