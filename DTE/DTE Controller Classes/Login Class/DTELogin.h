//
//  DTELogin.h
//  DTE
//
//  Created by Divya Jain on 5/1/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTELogin : BaseClass <UITextFieldDelegate>
{
    IBOutletCollection(UITextField) NSArray *allTxtFields;
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtPassword;
}
- (IBAction)SubmitAction:(id)sender;
- (IBAction)BackAction:(id)sender;
- (IBAction)SignUpAction:(id)sender;
- (IBAction)SearchProductAction:(id)sender;
- (IBAction)CartAction:(id)sender;
- (IBAction)SettingsAction:(id)sender;


@end
