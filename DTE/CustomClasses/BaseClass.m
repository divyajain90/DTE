//
//  BaseClass.m
//  DTE
//
//  Created by Divya Jain on 5/3/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "BaseClass.h"

@interface BaseClass ()

@end

@implementation BaseClass

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlertTitle:(NSString*)title message:(NSString*)msg
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
@end
