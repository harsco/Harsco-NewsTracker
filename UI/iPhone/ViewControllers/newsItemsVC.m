//
//  newsItemsVC.m
//  Germanium
//
//  Created by SadikAli on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "newsItemsVC.h"

@interface newsItemsVC ()

@end

@implementation newsItemsVC

@synthesize newsTable;
@synthesize newsHeader;
@synthesize rssFeedTopic;
@synthesize loadingIndicator;

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
    
    //self.newsHeader.topItem.title = rssFeedTopic;
    self.newsHeader.topItem.title = @"News Items";
    
    dataArray = [[NSMutableArray alloc] init];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.loadingIndicator setHidden:NO];
    [self.loadingIndicator startAnimating];
    
    [self fetchRSSFeed];
    
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

-(void)fetchRSSFeed
{
    RSSParser* parser = [[RSSParser alloc] init];
    parser.delegate = self;
    
   // [parser fetchRssFeedFromURL:@"http://news.google.com/news?um=1&ned=us&hl=en&q=TubeCity&output=rss"];
    
    [parser fetchRssFeedFromURL:[NSString stringWithFormat:@"%@%@%@",@"http://news.google.com/news?um=1&ned=us&hl=en&q=",self.rssFeedTopic,@"&output=rss"]];
}

#pragma mark - RSS Parser Delegate
-(void)feedFetchingDidFinish:(NSMutableArray *)stories
{
    NSLog(@"stories count is %d",[stories count]);
    
    [self.loadingIndicator stopAnimating];
    [self.loadingIndicator setHidden:YES];
    
    //  NSLog(@"%@",[stories objectAtIndex:3]);
    
    if([stories count] == 0)
    {
        
//        NSMutableDictionary* temp = [[NSMutableDictionary alloc] init];
//        [temp setObject:@"Unable to Get Data" forKey:@"title"];
//        dataArray = [[NSMutableArray alloc] initWithObjects:temp, nil];
    }
    else 
    {
        dataArray = [stories retain];
        
        [self.newsTable reloadData];
    }
    
    
    
}

-(void)feedFetchingDidFail
{
    [self.loadingIndicator stopAnimating];
    [self.loadingIndicator setHidden:YES];
    [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:@"Unable to fetch News Items"];
    
    [self dismissModalViewControllerAnimated:YES];
    
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
    if([dataArray count])
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



@end
