//
//  SettingsVC.h
//  Germanium
//
//  Created by SadikAli on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rssInputView.h"


@interface SettingsVC : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    IBOutlet UINavigationBar* settingsHeader;
    IBOutlet UIButton* modifyRSSButton;
    IBOutlet UIButton* resetButton;
    UITextField *myTextField;
    UIAlertView *myAlertView;
}


@property(nonatomic,retain)UINavigationBar* settingsHeader;
@property(nonatomic,retain)UIButton* modifyRSSButton;
@property(nonatomic,retain)UIButton* resetButton;


-(IBAction)onModifyRSSClicked:(id)sender;
- (IBAction)useridtextFieldDone:(id)sender;
-(IBAction)resetButtonClicked:(id)sender;

@end
