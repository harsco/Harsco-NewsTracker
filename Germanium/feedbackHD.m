//
//  feedbackHD.m
//  Germanium
//
//  Created by SadikAli on 9/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "feedbackHD.h"

@interface feedbackHD ()

@end

@implementation feedbackHD

#define kLeftMargin				20.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kTweenMargin			10.0

#define kTextFieldHeight		30.0
#define kTextFieldWidth	300.0



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.title = @"Feedback";
    // self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
    CGFloat nRed=26.0/255.0; 
    CGFloat nBlue=78/255.0;
    CGFloat nGreen=134.0/255.0;
    UIColor *myColor=[[UIColor alloc]initWithRed:nRed green:nBlue blue:nGreen alpha:1];
    
    self.navigationController.navigationBar.tintColor = myColor;
    [myColor release];
    
    
    // self.navigationController.navigationBar.tintColor = [UIColor colorWithCGColor:<#(CGColorRef)#>
	feedBackCaptions = [[NSMutableArray alloc] initWithObjects:@"Your E-Mail",@"Subject",@"Message",nil];
	
    
    UIImage* image = [UIImage imageNamed:@"app_btn_back"];
    CGRect frameimg = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onHomeClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = backButton;
	//[delegate RegisterKeyBoardState:self];
	//[self.navigationController hidesBottomBarWhenPushed:NO];
	//self.navigationController.toolbarHidden = NO;
	//self.navigationController.toolbar.barStyle = UIBarStyleBlackOpaque;
	//[self.navigationController.	addSubview:sendBtn];
    
    messageTxtField.text = @"";
    subjectTxtField.text = @"";
    mailTxtField.text = @"";

}


- (void)viewWillAppear:(BOOL)animated 
{
	[super viewWillAppear:animated];
    toolbar = [[UIToolbar alloc] init];
	toolbar.barStyle = UIBarStyleBlackOpaque;
    
    CGFloat nRed=26.0/255.0; 
    CGFloat nBlue=78/255.0;
    CGFloat nGreen=134.0/255.0;
    UIColor *myColor=[[UIColor alloc]initWithRed:nRed green:nBlue blue:nGreen alpha:1];
    toolbar.tintColor = myColor;
    [myColor release];
    
	toolbar.frame =  CGRectMake(0.0, 900.0, 768.0, 44.0);
	[self.navigationController.view addSubview:toolbar];
	
	sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	sendBtn.frame = CGRectMake(107.0, 0.0, 106.0, 44.0);
	[sendBtn setImage:[UIImage imageNamed:@"btn_footer_send.png"] forState:UIControlStateNormal];
	[sendBtn addTarget:self action:@selector(onSendClick:)forControlEvents:UIControlEventTouchUpInside];
	[toolbar addSubview:sendBtn];
	isFeedBackSent = NO;
    
    messageTxtField.text = @"";
    subjectTxtField.text = @"";
    mailTxtField.text = @"";
    
	
}

-(void) RemoveKeyBoard
{
	if([mailTxtField isFirstResponder])
	{
		[mailTxtField resignFirstResponder];
	}
	else if([subjectTxtField isFirstResponder])
	{
		[subjectTxtField resignFirstResponder];
	}
	else 
	{
		[messageTxtField resignFirstResponder];
	}
	
}

- (void)viewDidAppear:(BOOL)animated 
{
    [super viewDidAppear:animated];
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered  target:self action:@selector(OnPlayerButtonClick:)];// (OnPlayerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
	[backButton release];
	
	
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[toolbar removeFromSuperview];
}


- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	
    return [emailTest evaluateWithObject:candidate];
}

-(void) onSendClick:(id) sender
{
    
    if(![mailTxtField.text length])
    {
        [App_GeneralUtilities showAlertOKWithTitle:@"Error" withMessage:@"Please enter your Email."];
        return;
    }
    else if(![subjectTxtField.text length])
    {
        [App_GeneralUtilities showAlertOKWithTitle:@"Error" withMessage:@"Please enter Subject."];
        return;
    }
    else if(![messageTxtField.text length])
    {
        [App_GeneralUtilities showAlertOKWithTitle:@"Error" withMessage:@"Please enter Your Message."];
        return;
    }
    
    
    
    if([mailTxtField.text length] && [subjectTxtField.text length] && [messageTxtField.text length])
    {
        if (![self validateEmail:mailTxtField.text])
        {
            
            [App_GeneralUtilities showAlertOKWithTitle:@"Error" withMessage:@"Please enter Valid Email."];
            return;
        }
    }
    
    [self showHUD:@"Sending"];
    
    SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
    testMsg.fromEmail = mailTxtField.text;
    testMsg.toEmail = @"harscosocialmedia@gmail.com";
    //testMsg.toEmail = @"lbrenckle@harsco.com";
    //testMsg.relayHost = @"smtp.harsco.com";
    //testMsg.relayHost = @"webmail.harsco.com";
    testMsg.relayHost = @"smtp.gmail.com";
    testMsg.requiresAuth = YES;
    testMsg.login = @"harscosocialmedia@gmail.com";
    testMsg.pass = @"Harsco123";
    testMsg.subject = subjectTxtField.text;
    testMsg.bccEmail = @"testbcc@test.com";
    testMsg.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!
    
    // Only do this for self-signed certs!
    // testMsg.validateSSLChain = NO;
    testMsg.delegate = self;
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               messageTxtField.text,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
    [testMsg send];
    
}

#pragma mark-action methods
#pragma mark - Action Methods
-(void)onHomeClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void) onTimer:(NSTimer*) timer
{
	if (alert == nil) {
		return;
	}
	[alert dismissWithClickedButtonIndex:0 animated:YES];
	//[importFavListMsgBox release];
	alert = nil;
	if(isFeedBackSent)
	{
		
		[self.navigationController popViewControllerAnimated:YES];
	}
}
// alert delegate
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// use "buttonIndex" to decide your action
	//
}

- (void)viewDidUnload 
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	//[self.navigationController setToolbarHidden:YES];
	//self.navigationController.navigationBarHidden = NO;
	[toolbar release];
	[mailTxtField release];
	[subjectTxtField release];
	[messageTxtField release];
	[feedBackCaptions release];
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
	//MobileRemoteAppDelegate *delegate = (MobileRemoteAppDelegate*) app.delegate;
	//delegate.appTimeStamp = CFAbsoluteTimeGetCurrent();
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark Table view methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if([indexPath section] == 2)
		return 220.0;
    return 80;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	
    
    return [feedBackCaptions objectAtIndex: section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	
	//MobileRemoteAppDelegate *delegate = (MobileRemoteAppDelegate*) app.delegate;
	//delegate.appTimeStamp = CFAbsoluteTimeGetCurrent();
	
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        
        
		if([indexPath section] == 0)
		{
			if(!mailTxtField)
			{
				//mailTxtField = [self textFieldRounded];
				CGRect frame = CGRectMake(40.0, 0.0, 295.0, 37);
				mailTxtField = [[UITextField alloc] initWithFrame:frame];
				
				mailTxtField.borderStyle = UITextBorderStyleNone;
				mailTxtField.textColor = [UIColor blackColor];
				mailTxtField.font = [UIFont systemFontOfSize:17.0];
				//textFieldRounded.placeholder = @"<enter text>";
				mailTxtField.backgroundColor = [UIColor whiteColor];
				mailTxtField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
				
				mailTxtField.keyboardType = UIKeyboardTypeDefault;
				mailTxtField.returnKeyType = UIReturnKeyDone;
				
				mailTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
				//textFieldRounded
				
				//textFieldRounded.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
				
				mailTxtField.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
				
				// Add an accessibility label that describes what the text field is for.
				//[textFieldRounded setAccessibilityLabel:NSLocalizedString(@"RoundedTextField", @"")];
                mailTxtField.layer.cornerRadius = 10.0f;
				
			}
			[cell.contentView addSubview:mailTxtField];
			
		}
		else if([indexPath section] == 1)
		{
			if(!subjectTxtField)
			{
				//subjectTxtField = [self textFieldRounded];
				CGRect frame = CGRectMake(4.0, 0.0, 295, 37);
				subjectTxtField = [[UITextField alloc] initWithFrame:frame];
				
				subjectTxtField.borderStyle = UITextBorderStyleNone;
				subjectTxtField.textColor = [UIColor blackColor];
				subjectTxtField.font = [UIFont systemFontOfSize:17.0];
				//textFieldRounded.placeholder = @"<enter text>";
				subjectTxtField.backgroundColor = [UIColor whiteColor];
				subjectTxtField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
				
				subjectTxtField.keyboardType = UIKeyboardTypeDefault;
				subjectTxtField.returnKeyType = UIReturnKeyDone;
				
				subjectTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
				//textFieldRounded
				
				//textFieldRounded.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
				
				subjectTxtField.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
				
				// Add an accessibility label that describes what the text field is for.
				//[textFieldRounded setAccessibilityLabel:NSLocalizedString(@"RoundedTextField", @"")];
                subjectTxtField.layer.cornerRadius = 10.0f;
				
			}
			[cell.contentView addSubview:subjectTxtField];
			
		}
		else if([indexPath section] == 2)
		{
			//messageTxtField = [self textFieldRounded];
			if(!messageTxtField)
			{
				CGRect frame = CGRectMake(2.0, 0.0, 295, 107.0);
				messageTxtField = [[UITextView alloc] initWithFrame:frame];
				
				//messageTxtField.borderStyle = UITextBorderStyleNone;
				messageTxtField.textColor = [UIColor blackColor];
				messageTxtField.font = [UIFont systemFontOfSize:17.0];
				//messageTxtField.placeholder = @"<enter text>";
				messageTxtField.backgroundColor = [UIColor whiteColor];
				messageTxtField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
				
				messageTxtField.keyboardType = UIKeyboardTypeDefault;
				messageTxtField.returnKeyType = UIReturnKeyDone;
				
				//messageTxtField.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
				//textFieldRounded
				
				//textFieldRounded.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
				
				messageTxtField.delegate = self;
				//
				//messageTxtField.frame = CGRectMake(0.0, 0.0, 305.0, 100.0);
                messageTxtField.layer.cornerRadius = 10.0f;
				
			}
			[cell.contentView addSubview:messageTxtField];
			
			
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // Set up the cell...
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}
- (BOOL)textView:( UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *) text
{
	if([text isEqualToString:@"\n"])
	{
		[textView resignFirstResponder];
		return FALSE;
	}
	return TRUE;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	// the user pressed the "Done" button, so dismiss the keyboard
	[textField resignFirstResponder];
	return YES;
}


- (void)messageSent:(SKPSMTPMessage *)message
{
    [message release];
    [self dismissHUD];
    
    NSLog(@"delegate - message sent");
    
    [App_GeneralUtilities showAlertOKWithTitle:@"Success" withMessage:@"Feedback Sent"];
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    //[message release];
    NSLog(@"error in sending - message sent %@",[error localizedDescription]);
    
    [self dismissHUD];
    
    [App_GeneralUtilities showAlertOKWithTitle:@"Error in Communication" withMessage:@"Unable to Send Feedback"];
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark HUD Methods 
- (void)showHUD:(NSString *)message {
    if(!hudAnimatedView){
        hudAnimatedView = [VZAnimatedView animatedViewWithSuperView:self.view
                                                          labelText:message
                                                          dimScreen:NO];
    }
}

-(void)dismissHUD
{
    if (hudAnimatedView) {
        [hudAnimatedView dismissView];
        hudAnimatedView = nil;
    } 
}




- (void)dealloc 
{
    [super dealloc];
	[toolbar release];
	[mailTxtField release];
	[subjectTxtField release];
	[messageTxtField release];
	[feedBackCaptions release];
}

@end
