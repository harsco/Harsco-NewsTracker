//
//  editableTableVC.h
//  Germanium
//
//  Created by SadikAli on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface editableTableVC : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
{
    IBOutlet UITableView* editableTable;
    IBOutlet UINavigationBar* newsHeader;
    
    UITextField *myTextField;
    UIAlertView* myAlertView;
    
    NSMutableArray* dataArray;

}

@property(nonatomic,retain)UITableView* editableTable;
@property(nonatomic,retain)UINavigationBar* newsHeader;

- (void)addButtons:(BOOL)editing;

@end
