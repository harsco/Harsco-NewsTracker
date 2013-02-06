//
//  FeedBackViewController.h
//  MobileRemote
//
//  Created by v981481 on 17/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FeedBackViewController :UITableViewController <UITextFieldDelegate, UITextViewDelegate,UIAlertViewDelegate>
{
	NSMutableArray *feedBackCaptions;
	//UITextField		*textFieldRounded;
	UITextField *mailTxtField;
	UITextField *subjectTxtField;
	UITextView *messageTxtField;
	UIToolbar *toolbar;
	UIButton *sendBtn;
	UIAlertView *alert;
	BOOL isFeedBackSent;
	
	
}

@end
