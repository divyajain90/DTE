//
//  DTELogin.m
//  DTE
//
//  Created by Divya Jain on 5/1/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "DTELogin.h"

@interface DTELogin ()

@end

@implementation DTELogin

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
//    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"]
//                                                                       style:UIBarButtonItemStylePlain
//                                                                      target:self
//                                                                      action:@selector(goBack)];
//    
//    //set back button color
//    [backButtonItem setTintColor:[UIColor whiteColor]];
//    //set back button arrow color
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationItem setLeftBarButtonItem:backButtonItem];

}

#pragma mark - Misc
-(void)initUI
{
        [self.navigationController setNavigationBarHidden:YES];
    [self setUIForTextBox:txtEmail];
    [self setUIForTextBox:txtPassword];
}

#pragma mark - Actions

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];


}
- (IBAction)SubmitAction:(id)sender {
    if(txtEmail.text.length<=0)
    {
        [self showAlertTitle:nil message:@"Enter Email."];
    }
    else if (txtPassword.text.length<=0)
    {
        [self showAlertTitle:nil message:@"Enter Password."];
    }
    else
    {
        [self hideKeyboard];
        
    
//    [User sharedUser].email =@"h@gmail.com";
//    [User sharedUser].password =@"Divya";
    
        [User sharedUser].email =[txtEmail.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        [User sharedUser].password =[txtPassword.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    
    [Utility showHUDOnView:self.view];
    [[User sharedUser]  signIn:[User sharedUser] WithCompletionBlock:^(NSError *error, NSDictionary*res) {
        [Utility hideHUDOnView:self.view];
        if (!error) {
            
            
            if ([res[@"Msg"] isEqualToString:@"0"]) {
                [self showAlertTitle:@"Login failed!!" message:@"Please enter valid email ID."];
                
            }
            else
            {
//                [self showAlertTitle:@"" message:@"Login successfully!"];
                [Utility showMessage:@"Login successfully!" OnView:self.view];
                [self performSelector:@selector(BackAction:) withObject:nil afterDelay:2.0];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMenu" object:nil];
                
            }
            
        }
        else
            [self showAlertTitle:@"" message:[error description]];
        
    }];
    }
}

- (IBAction)BackAction:(id)sender {
    GO_BACK;
}

- (IBAction)SignUpAction:(id)sender {
    [self performSegueWithIdentifier:@"signUpSegue" sender:nil];

}
- (IBAction)SearchProductAction:(id)sender
{
    ALERT_UnderProcess;
}
- (IBAction)CartAction:(id)sender
{
    ALERT_UnderProcess;
}
- (IBAction)SettingsAction:(id)sender
{
    ALERT_UnderProcess;
}

#pragma mark - TextField delegates
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if (textField != txtEmail) {
        
        return newLength <= 25;
    }
    else
        return 254;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan)
    {
        for (UITextField *tf in allTxtFields) {
            [tf resignFirstResponder];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == txtEmail) {
        [txtPassword becomeFirstResponder];
    }
    
    else{
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)setUIForTextBox: (UITextField*)text
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    text.leftView = paddingView;
    text.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)hideKeyboard
{
    for (UITextField *text in allTxtFields) {
        if ([text isFirstResponder]) {
            [text resignFirstResponder];
        }
    }
    
}

@end
