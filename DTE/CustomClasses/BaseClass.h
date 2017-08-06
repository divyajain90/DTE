//
//  BaseClass.h
//  DTE
//
//  Created by Divya Jain on 5/3/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface BaseClass : UIViewController<UIAlertViewDelegate>
{

}

@property(strong,nonatomic)AppDelegate*app;

-(void)showAlertTitle:(NSString*)title message:(NSString*)msg;
@end
