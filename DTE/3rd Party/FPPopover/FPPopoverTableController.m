//
//  DemoTableControllerViewController.m
//  FPPopoverDemo
//
//  Created by Alvise Susmel on 4/13/12.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import "FPPopoverTableController.h"
@interface FPPopoverTableController ()

@end

@implementation FPPopoverTableController
@synthesize delegate = _delegate;
@synthesize itemsArr;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Popover Title";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view setBackgroundColor:BaseGreenColor];
    
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setSeparatorColor:[UIColor greenColor]];
    
    self.view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    self.view.layer.shadowOffset = CGSizeMake(2, 2);
    self.view.layer.shadowOpacity = 1;
    self.view.layer.shadowRadius = 0.5;
    
//    tableView.layer.borderWidth = 2.0;
//    tableView.layer.borderColor = [UIColor redColor].CGColor;

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];


    }
    cell.textLabel.text = [itemsArr objectAtIndex:indexPath.row];
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0f]];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    return cell;
}


#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if([self.delegate respondsToSelector:@selector(selectedTableRow:)])
//    {
////        [self.delegate selectedTableRow:indexPath.row];
//    }
    if ([self.delegate respondsToSelector:@selector(selectedItem:selectedRow:)]) {
        [self.delegate selectedItem:itemsArr[indexPath.row] selectedRow:indexPath.row ];
    
    }
}




@end
