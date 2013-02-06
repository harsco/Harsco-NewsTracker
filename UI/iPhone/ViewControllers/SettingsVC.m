//
//  SettingsVC.m
//  Germanium
//
//  Created by SadikAli on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsVC.h"

@interface SettingsVC ()

@end

@implementation SettingsVC

@synthesize settingsHeader;
@synthesize modifyRSSButton;
@synthesize resetButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage* image = [UIImage imageNamed:@"app_btn_back"];
    CGRect frameimg = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onHomeClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.settingsHeader.topItem.leftBarButtonItem = backButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

#pragma mark-action methods
#pragma mark - Action Methods

-(IBAction)onModifyRSSClicked:(id)sender
{
    //rssInputView* dummy = [[rssInputView alloc] initWithTitle:@"Sign In- Safety Alerts" message:nil delegate:self cancelButtonTitle:@"Sign In" otherButtonTitles:@"Cancel", nil];
    
//    UIAlertView* dummy = [[UIAlertView alloc] initWithTitle:@"Sign In- Safety Alerts" message:nil delegate:self cancelButtonTitle:@"Sign In" otherButtonTitles:@"Cancel", nil];
//    
//    CGRect iframe = CGRectMake(21.0, 48.0, 244.0, 31.0);
//    UITextField* useridtext = [[UITextField alloc] initWithFrame:iframe];
//    
//    [dummy addSubview:useridtext];
    
    myAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Enter RSS Feed", @"new_list_dialog")
                                                          message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    myAlertView.delegate = self;
    
    myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    
    myTextField.delegate = self;
    [myTextField setBackgroundColor:[UIColor whiteColor]];
    myTextField.textAlignment = UITextAlignmentLeft;
    myTextField.borderStyle = UITextBorderStyleRoundedRect;
    myTextField.placeholder = @"RSS Feed";
    myTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    myTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    myTextField.keyboardType = UIKeyboardTypeDefault;
    myTextField.returnKeyType = UIReturnKeyDone;
    [myTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [myTextField setKeyboardAppearance:UIKeyboardAppearanceAlert];
   
    [myTextField addTarget:self action:@selector(useridtextFieldDone:) forControlEvents:UIControlEventEditingDidEnd];
    
    [myAlertView addSubview:myTextField];
    [myAlertView show];
    [myAlertView release];

    
    //[dummy show];
}

-(IBAction)resetButtonClicked:(id)sender
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Reset Alert" message:@"Are You Sure to Reset?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [alert show];
    [alert release];
    
    

}

-(void)onHomeClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark UIAlertViewDelegate Method

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"index is %d",buttonIndex);
    
       
    if([alertView isEqual:myAlertView])
    {
    
        if(buttonIndex == 1 && [myTextField.text length] >1)
        {
            NSLog(@"text is %@",[myTextField text]);
            
           // [[NSNotificationCenter defaultCenter] postNotificationName:@"RSSCHNGE" object:self];
            
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"RSSCHANGE"];
            [[NSUserDefaults standardUserDefaults] setValue:[myTextField text] forKey:@"RSSFEED"];
        }
        else if(buttonIndex == 1 && [myTextField.text length] < 1)
        {
            UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Error Alert!!" message: @"RSS feed is Empty." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            [someError show];
            //[someError release];
        }
    }
    
    else 
    {
        NSLog(@"success");
        if(buttonIndex == 1)
        {
            [[NSUserDefaults standardUserDefaults] setValue:@"harsco" forKey:@"RSSFEED"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ISRESET"];
            
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"METALSACTIVECOMP"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"METALSACTIVECUST"];
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"INFRAACTIVECOMP"];
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"INFRAACTIVECUST"];
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RAILACTIVECOMP"];
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"RAILACTIVECUST"];
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"INDACTIVECOMP"];
             [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"INDACTIVECUST"];
            
        }
    }
       
    
}

#pragma mark UITextField Delgate


- (IBAction)useridtextFieldDone:(id)sender {
	//[sender resignFirstResponder];
    if ([myTextField.text length] < 1){
        
        
        UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Error Alert!!" message: @"RSS feed is Empty." delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
        [someError show];
        [someError release];
    }
    //[useridtext resignFirstResponder];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSLog(@"Keyboard Done Pressed");
	
	[myTextField resignFirstResponder];
    
    [myAlertView dismissWithClickedButtonIndex:0 animated:YES];
    
    [myAlertView.delegate alertView:myAlertView clickedButtonAtIndex:1];
    
    
	return YES;
}

@end
