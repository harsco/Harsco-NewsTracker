//
//  editableTableVC.m
//  Germanium
//
//  Created by SadikAli on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "editableTableVC.h"

@interface editableTableVC ()

@end

@implementation editableTableVC

@synthesize editableTable;
@synthesize newsHeader;

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
    self.newsHeader.topItem.leftBarButtonItem = backButton;
    
    
   // dataArray = [[NSMutableArray alloc] initWithObjects:@"BIS",@"Hertel",nil];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
    
    self.newsHeader.topItem.leftBarButtonItem = editButton;
    
    [editButton release];
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
-(void)onHomeClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)editAction:(id)sender {
	[self.editableTable setEditing:YES animated:YES];
	[self addButtons:self.editableTable.editing];
}

- (void)doneAction:(id)sender {
	[self.editableTable setEditing:NO animated:YES];
	[self addButtons:self.editableTable.editing];
}

- (void)addAction:(id)sender 
{
    [self.editableTable setEditing:NO animated:YES];
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
}

- (void)addAddButton:(BOOL)right {
	// add + button as the nav bar's custom right view
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
								  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
	if (right) self.newsHeader.topItem.rightBarButtonItem = addButton;
	else self.newsHeader.topItem.rightBarButtonItem = addButton;
	[addButton release];
    
    
}


- (void)addButtons:(BOOL)editing {
	if (editing) {
		// Add the "done" button to the navigation bar
		UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
									   initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
		
		self.newsHeader.topItem.leftBarButtonItem = doneButton;
		[doneButton release];
        
		[self addAddButton:YES];
	} else {
		if ([dataArray count]) {
			// Add the "edit" button to the navigation bar
			UIBarButtonItem *editButton = [[UIBarButtonItem alloc]
										   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
			
			self.newsHeader.topItem.leftBarButtonItem = editButton;
            self.newsHeader.topItem.rightBarButtonItem = nil;
			[editButton release];
		} else {
			[self addAddButton:NO];
		}
		
//		if (self.showCancelButton) {
//			// add Cancel button as the nav bar's custom right view
//			UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
//										  initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
//			self.navigationItem.rightBarButtonItem = addButton;
//			[addButton release];
//		} else {
//			self.navigationItem.rightBarButtonItem = nil;
//		}
	}
}



#pragma mark TableView methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		// Load the top-level objects from the custom cell XIB.
        //NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Default_TableCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain). 
        //  cell = [topLevelObjects objectAtIndex:0];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.accessoryView = nil;
	}
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row] ;
}




#pragma mark TextField Delegate

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
