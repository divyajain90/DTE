//
//  DTEConstants.h
//  DTE
//
//  Created by Divya Jain on 5/1/17.
//  Copyright © 2017 Divya Jain. All rights reserved.
//

#ifndef DTEConstants_h
#define DTEConstants_h

#define GET_DEFAULTS \
[NSUserDefaults standardUserDefaults]


#define GET_STORYBOARD \
[UIStoryboard storyboardWithName:@"Main" bundle:nil]


#define BaseGreenColor \
[UIColor colorWithRed:54.0/255.0 green:139/255.0 blue:32.0/255.0 alpha:1.0]


//17 80 100

#define APPDELEGATE \
((AppDelegate*)[UIApplication sharedApplication].delegate)


#define GO_BACK \
[self.navigationController popViewControllerAnimated:YES]


#define ALERT_UnderProcess \
[Utility showMessage:@"Under Process" OnView:self.view]

#endif /* DTEConstants_h */
