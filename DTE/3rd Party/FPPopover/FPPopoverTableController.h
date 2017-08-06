//
//  DemoTableControllerViewController.h
//  FPPopoverDemo
//
//  Created by Alvise Susmel on 4/13/12.
//  Copyright (c) 2012 Fifty Pixels Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol FPPopupViewDelegate <NSObject>
//-(void)selectedTableRow:(NSUInteger)rowNum;
-(void)selectedItem:(NSString*)item selectedRow:(NSUInteger)rowNum;

@end


@interface FPPopoverTableController : UITableViewController
@property(nonatomic,weak) id<FPPopupViewDelegate> delegate;
@property (nonatomic, strong) NSArray *itemsArr;
@end
