//
//  competitorNewsVC.m
//  Germanium
//
//  Created by SadikAli on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "competitorNewsVC.h"

@interface competitorNewsVC ()

@end

@implementation competitorNewsVC
@synthesize newsTable;
@synthesize newsHeader;
@synthesize rssFeedTopic;
@synthesize spinningIndicator;

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
    
    [self.spinningIndicator setHidden:NO];
    
    [self fetchRSSFeed];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    //[self fetchRSSFeed];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}



-(void)fetchRSSFeed
{
    RSSParser* parser = [[RSSParser alloc] init];
    parser.delegate = self;
    
    [parser fetchRssFeedFromURL:@"http://news.google.com/news?um=1&ned=us&hl=en&q=TubeCity&output=rss"];
}

#pragma mark - RSS Parser Delegate
-(void)feedFetchingDidFinish:(NSMutableArray *)stories
{
    NSLog(@"stories count is %d",[stories count]);
    
  //  NSLog(@"%@",[stories objectAtIndex:3]);
    
    [self.spinningIndicator stopAnimating];
    [self.spinningIndicator setHidden:YES];
    
    dataArray = [stories retain];
    
    if([dataArray count] == 0)
    {
        [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:@"No News Items"];
    }
    else 
    {
        [newsTable reloadData];
    }
    
    
    
}

-(void)feedFetchingDidFail
{
    [self.spinningIndicator stopAnimating];
    [self.spinningIndicator setHidden:YES];
    [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:@"Unable to fetch News Items"];
}


#pragma mark-action methods
#pragma mark - Action Methods
-(void)onHomeClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark-Table methods
#pragma mark - Table Methods

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
    cell.textLabel.text = [[dataArray objectAtIndex:indexPath.row] objectForKey:@"title"] ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
    
    NSString * storyLink = [[dataArray objectAtIndex: storyIndex] objectForKey: @"link"];
    
    // clean up the link - get rid of spaces, returns, and tabs...
    storyLink = [storyLink stringByReplacingOccurrencesOfString:@" " withString:@""];
    storyLink = [storyLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    storyLink = [storyLink stringByReplacingOccurrencesOfString:@"	" withString:@""];
    
    NSLog(@"link: %@", storyLink);
    // open in Safari
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:storyLink]];
    
    newsWebVC* webView = [[newsWebVC alloc] initWithURLString:storyLink];    
    [self presentModalViewController:webView animated:YES];
    
    [webView release];
}


#pragma HUD methods
#pragma mark -
#pragma mark HUD Methods 
- (void)showHUD:(NSString *)message {
    if(!hudAnimatedView){
        hudAnimatedView = [VZAnimatedView animatedViewWithSuperView:self.newsTable
                                                          labelText:message
                                                          dimScreen:NO];
    }
}

- (void)dismissHUD{
    if (hudAnimatedView) {
        [hudAnimatedView dismissView];
        hudAnimatedView = nil;
    } 
}




@end
