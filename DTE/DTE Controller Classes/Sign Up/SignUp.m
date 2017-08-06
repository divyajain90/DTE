//
//  SignUp.m
//  DTE
//
//  Created by Divya Jain on 5/2/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import "SignUp.h"
#import "DTELogin.h"
@interface SignUp ()

@end

@implementation SignUp
#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
    
    NSLog(@"All categories: %@",[[APIManager sharedManager] categories]);

}

-(void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem * backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"]
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(goBack)];
    
    //set back button color
    [backButtonItem setTintColor:[UIColor whiteColor]];
    //set back button arrow color
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Misc

-(void)initUI
{
    [self.navigationController setNavigationBarHidden:YES];
    for (UITextField*txt in allTxtFields) {
        [self setUIForTextBox:txt];

    }
}
#pragma mark - Actions

-(void)goBack
{
    GO_BACK;
}


- (IBAction)SignUpAction:(id)sender {
    if (![self validateSignUp]) {
        return;
    }
    [self hideKeyboard];

//    [User sharedUser].fName =@"Divya";
//    [User sharedUser].lName =@"Jain";
//    [User sharedUser].mobile =@"9865429239";
//    [User sharedUser].email =@"h@gmail.com";
//    [User sharedUser].password =@"Divya";
//    
    
    [User sharedUser].fName =[txtFirstName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [User sharedUser].lName =[txtLastName.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [User sharedUser].mobile =[txtMobile.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [User sharedUser].email =[txtEmail.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    [User sharedUser].password =[txtPswd.text stringByReplacingOccurrencesOfString:@" " withString:@""];


    [Utility showHUDOnView:self.view];
    [[User sharedUser] signUP:[User sharedUser] withCompletionBlock:^(NSError *error, NSDictionary*res) {
        [Utility hideHUDOnView:self.view];
        if (!error) {
            
            if ([res[@"Msg"] isEqualToString:@"Email already exists."]) {
                [self showAlertTitle:@"" message:res[@"Msg"]];
            }
            else
            {
                [[User sharedUser] saveUser];
                [Utility showMessage:@"Registered successfully!" OnView:self.view];
//                [self showAlertTitle:@"" message:@"Registered successfully!"];
                [self performSelector:@selector(goBack) withObject:nil afterDelay:2.0];
            }

        }
else
    [self showAlertTitle:@"" message:[error description]];

    }];

    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}

-(BOOL)validateSignUp
{BOOL isValidate = YES;
    NSString *str;
    for (UITextField *txt in allTxtFields) {
        str = [txt.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (str.length == 0) {
            [self showAlertTitle:@"Message" message:@"Please fill all the details"];
            isValidate = NO;
            break;
        }
        
    }
    if (isValidate) {
        if ([self isValidEmail]) {
            
            if (![txtPswd.text isEqualToString:txtConfirmPswd.text]) {
                [self showAlertTitle:@"Message" message:@"Passwords do not match!"];
                txtPswd.text =nil;
                txtConfirmPswd.text = nil;
                isValidate = NO;
            }
            else
            {
                if (txtPswd.text.length < 6) {
                    [self showAlertTitle:@"Message" message:@"The minimum password length is 6."];
                    txtPswd.text =nil;
                    txtConfirmPswd.text = nil;
                    isValidate = NO;
                }
            }
        }
        else
            isValidate = NO;
    }
    return isValidate;
}

-(BOOL)isValidEmail
{
    BOOL isValidMail = YES;
    NSString *regExPattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:txtEmail.text options:0 range:NSMakeRange(0, [txtEmail.text length])];
    NSLog(@"regExMatches %lu", (unsigned long)regExMatches);
    if (regExMatches == 0 && txtEmail.text.length>0){
        [self showAlertTitle:@"" message:@"Please enter a valid email."];
        txtEmail.text = nil;
        isValidMail = NO;
    }
    return isValidMail;
    
}



- (IBAction)BackAction:(id)sender {
    GO_BACK;
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
    if (textField == txtFirstName) {
        [txtLastName becomeFirstResponder];
    }
    else if (textField == txtLastName) {
        [txtEmail becomeFirstResponder];
    }
    else if (textField == txtEmail) {
        [txtPswd becomeFirstResponder];
    }
    else if (textField == txtPswd) {
        [txtConfirmPswd becomeFirstResponder];
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
