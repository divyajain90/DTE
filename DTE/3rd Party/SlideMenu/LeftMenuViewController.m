//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"

@implementation LeftMenuViewController

#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self.slideOutAnimationEnabled = YES;
	
	return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.tableView.separatorColor = [UIColor greenColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.backgroundColor = BaseGreenColor;
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:@"updateMenu" object:nil];
}

//-(void)reloadTable
//{
//    [self.tableView reloadData ];
//}
#pragma mark - UITableView Delegate & Datasrouce

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
//   id arr = [NSKeyedUnarchiver unarchiveObjectWithData:[GET_DEFAULTS objectForKey:@"user"]];
//    NSLog(@" User is :%@",arr);
//    
    if ([[User sharedUser]isLoggedIn]) {
        return 3;

    }
   else
	return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 20)];
	view.backgroundColor = [UIColor clearColor];
	return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftMenuCell"];
    cell.textLabel.textColor = [UIColor whiteColor];
    if ([[User sharedUser]isLoggedIn]) {
        switch (indexPath.row)
        {
            case 0:
                cell.textLabel.text = [@"Hi " stringByAppendingString:[NSString stringWithFormat:@"%@!",[User sharedUser].fName]];
                break;
                
            case 1:
                cell.textLabel.text = @"Home";
                break;
                
            case 2:
            {
                cell.textLabel.text = @"Logout";
                
            }
                break;
        }
    }
    else
    {
    switch (indexPath.row)
	{
		case 0:
			cell.textLabel.text = @"Home";
			break;
			
		case 1:
			cell.textLabel.text = @"Login";
			break;
            
	}
    }
	cell.backgroundColor = [UIColor clearColor];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	UIViewController *vc ;
    if ([[User sharedUser]isLoggedIn]) {
        switch (indexPath.row)
        {
            case 0:
                break;
                
            case 1:
                vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"HomeView"];

                break;
                
            case 2:
            {
                [[User sharedUser] logout ];
            }
                break;
        }

        
    }
    else{
	switch (indexPath.row)
	{
		case 0:
			vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"HomeView"];
			break;
			
		case 1:
			vc = [GET_STORYBOARD instantiateViewControllerWithIdentifier: @"Login"];
			break;
			
		case 3:
			[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
			[[SlideNavigationController sharedInstance] popToRootViewControllerAnimated:YES];
			return;
			break;
	}
    }
	[[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc
															 withSlideOutAnimation:self.slideOutAnimationEnabled
																	 andCompletion:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
