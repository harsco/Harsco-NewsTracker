//
//  FeedBackViewController.m
//  MobileRemote
//
//  Created by v981481 on 17/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FeedBackViewController.h"
#import "MobileRemoteAppDelegate.h"
#define kLeftMargin				20.0
#define kTopMargin				20.0
#define kRightMargin			20.0
#define kTweenMargin			10.0

#define kTextFieldHeight		30.0
#define kTextFieldWidth	260.0
@implementation FeedBackViewController
//@synthesize textFieldRounded;
/*
 - (id)initWithStyle:(UITableViewStyle)style {
 // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 if (self = [super initWithStyle:style]) {
 }
 return self;
 }
 */


- (void)viewDidLoad 
{
    [super viewDidLoad];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.title = @"Feedback";
	feedBackCaptions = [[NSMutableArray alloc] initWithObjects:@"Your E-Mail",@"Subject",@"Message",nil];
	
	toolbar = [[UIToolbar alloc] init];
	toolbar.barStyle = UIBarStyleBlackOpaque;
	toolbar.frame =  CGRectMake(0.0, 436.0, 320.0, 44.0);
	[self.navigationController.view addSubview:toolbar];
	
	sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	sendBtn.frame = CGRectMake(107.0, 0.0, 106.0, 44.0);
	[sendBtn setImage:[UIImage imageNamed:@"btn_footer_send.png"] forState:UIControlStateNormal];
	[sendBtn addTarget:self action:@selector(OnButtonClick:)forControlEvents:UIControlEventTouchUpInside];
	[toolbar addSubview:sendBtn];
	isFeedBackSent = NO;
	//[delegate RegisterKeyBoardState:self];
	//[self.navigationController hidesBottomBarWhenPushed:NO];
	//self.navigationController.toolbarHidden = NO;
	//self.navigationController.toolbar.barStyle = UIBarStyleBlackOpaque;
	//[self.navigationController.	addSubview:sendBtn];	
}

- (void)viewWillAppear:(BOOL)animated 
{
	[super viewWillAppear:animated];
	
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


/*- (void)viewDidDisappear:(BOOL)animated
 {
 [super viewDidDisappear:animated];
 
 
 }*/


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */
- (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	
    return [emailTest evaluateWithObject:candidate];
}

-(void) OnButtonClick:(id) sender
{
	if((UIButton *) sender == sendBtn)
	{
		UIApplication *app = [UIApplication sharedApplication];
		MobileRemoteAppDelegate *delegate = (MobileRemoteAppDelegate*) app.delegate;
		
		if([mailTxtField.text length])
		{
			if ([self validateEmail:mailTxtField.text])
			{
				if (![subjectTxtField.text length]) 
				{
					alert = [delegate CreatePopUpMsg:nil :@"Please enter Subject." :self :@"OK" :nil];
					
					[alert show];	
					//[alert release];
					return;
				}
				else if (![messageTxtField.text length])
				{
					alert = [delegate CreatePopUpMsg:nil :@"Please enter Message." :self :@"OK" :nil];
					[alert show];	
					//[alert release];
					return;
				}
			}
			else 
			{
				alert = [delegate CreatePopUpMsg:nil :@"Please enter valid E-mail address." :self :@"OK" :nil];
				[alert show];	
				//[alert release];
				return;
				
			}
			
		}
		else 
		{
			alert = [delegate CreatePopUpMsg:nil :@"Please enter E-mail address." :self :@"OK" :nil]; 
			[alert show];	
			//[alert release];
			return;
		}
		
		NSInteger nResult = [delegate.sarovarConObj SendFeedBack:mailTxtField.text Email:subjectTxtField.text Comment:messageTxtField.text];
		
		if(nResult)
		{
			//error
			alert = [delegate CreatePopUpMsg:@"Feedback" :@"Feedback could not be sent" :self :nil :nil];
			[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(onTimer:) userInfo:nil repeats:NO];
			
		}
		else 
		{
			//success
			isFeedBackSent = YES;
			alert = [delegate CreatePopUpMsg:@"Feedback" :@"Feedback sent" :self :nil :nil]; 
			[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(onTimer:) userInfo:nil repeats:NO];
		}
		[alert show];	
		//[alert release];
	}
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
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload 
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	//[self.navigationController setToolbarHidden:YES];
	//self.navigationController.navigationBarHidden = NO;
	
	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UIApplication *app = [UIApplication sharedApplication];
	MobileRemoteAppDelegate *delegate = (MobileRemoteAppDelegate*) app.delegate;
	delegate.appTimeStamp = CFAbsoluteTimeGetCurrent();
}

#pragma mark Table view methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if([indexPath section] == 2)
		return 110.0; 
	return 40;
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
    
	UIApplication *app = [UIApplication sharedApplication];
	MobileRemoteAppDelegate *delegate = (MobileRemoteAppDelegate*) app.delegate;
	delegate.appTimeStamp = CFAbsoluteTimeGetCurrent();
	
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		if([indexPath section] == 0)
		{
			if(!mailTxtField)
			{
				//mailTxtField = [self textFieldRounded];
				CGRect frame = CGRectMake(kLeftMargin, 8.0, kTextFieldWidth, kTextFieldHeight);
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
				
			}
			[cell.contentView addSubview:mailTxtField];
			
		}
		else if([indexPath section] == 1)
		{
			if(!subjectTxtField)
			{
				//subjectTxtField = [self textFieldRounded];
				CGRect frame = CGRectMake(kLeftMargin, 8.0, kTextFieldWidth, kTextFieldHeight);
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
				
			}
			[cell.contentView addSubview:subjectTxtField];
			
		}
		else if([indexPath section] == 2)
		{
			//messageTxtField = [self textFieldRounded];
			if(!messageTxtField)
			{
				CGRect frame = CGRectMake(kLeftMargin, 8.0, kTextFieldWidth, 100);
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

/*- (UITextField *)textFieldRounded
 {
 UITextField * textFieldRounded = nil;
 if (textFieldRounded == nil)
 {
 CGRect frame = CGRectMake(kLeftMargin, 8.0, kTextFieldWidth, kTextFieldHeight);
 textFieldRounded = [[UITextField alloc] initWithFrame:frame];
 
 textFieldRounded.borderStyle = UITextBorderStyleNone;
 textFieldRounded.textColor = [UIColor blackColor];
 textFieldRounded.font = [UIFont systemFontOfSize:17.0];
 //textFieldRounded.placeholder = @"<enter text>";
 textFieldRounded.backgroundColor = [UIColor whiteColor];
 textFieldRounded.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
 
 textFieldRounded.keyboardType = UIKeyboardTypeDefault;
 textFieldRounded.returnKeyType = UIReturnKeyDone;
 
 textFieldRounded.clearButtonMode = UITextFieldViewModeWhileEditing;	// has a clear 'x' button to the right
 //textFieldRounded
 
 //textFieldRounded.tag = kViewTag;		// tag this control so we can remove it later for recycled cells
 
 textFieldRounded.delegate = self;	// let us be the delegate so we know when the keyboard's "Done" button is pressed
 
 // Add an accessibility label that describes what the text field is for.
 //[textFieldRounded setAccessibilityLabel:NSLocalizedString(@"RoundedTextField", @"")];
 }
 return textFieldRounded;
 }*/

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


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

