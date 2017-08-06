//
//  SignUp.h
//  DTE
//
//  Created by Divya Jain on 5/2/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUp : BaseClass<UITextViewDelegate>
{
    __weak IBOutlet UITextField *txtFirstName;
    __weak IBOutlet UITextField *txtLastName;
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtPswd;
    __weak IBOutlet UITextField *txtConfirmPswd;
    __weak IBOutlet UITextField *txtMobile;
    IBOutletCollection(UITextField) NSArray *allTxtFields;

}

- (IBAction)SignUpAction:(id)sender;
- (IBAction)BackAction:(id)sender;
- (IBAction)SearchProductAction:(id)sender;
- (IBAction)CartAction:(id)sender;
- (IBAction)SettingsAction:(id)sender;



@end
