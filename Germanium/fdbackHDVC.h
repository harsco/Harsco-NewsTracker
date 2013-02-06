//
//  fdbackHDVC.h
//  Germanium
//
//  Created by SadikAli on 9/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "App_GeneralUtilities.h"

#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import <CFNetwork/CFNetwork.h>

#import "VZAnimatedView.h"


@interface fdbackHDVC : UIViewController<UITextFieldDelegate, UITextViewDelegate,UIAlertViewDelegate,SKPSMTPMessageDelegate,UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView* table;
    
    NSMutableArray *feedBackCaptions;
    //UITextField		*textFieldRounded;
    UITextField *mailTxtField;
    UITextField *subjectTxtField;
    UITextView *messageTxtField;
    UIToolbar *toolbar;
    UIButton *sendBtn;
    UIAlertView *alert;
    BOOL isFeedBackSent;
    
    VZAnimatedView *hudAnimatedView;
}

@property(nonatomic,retain)UITableView* table;

- (void)showHUD:(NSString *)message;
-(void)dismissHUD;

@end
