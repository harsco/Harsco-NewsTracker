//
//  competitorListVC.m
//  Germanium
//
//  Created by SadikAli on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "competitorListVC.h"

@interface competitorListVC ()

@end

@implementation competitorListVC

@synthesize competitorTable;
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
    
    divisionDict = [[NSMutableDictionary alloc] init];
    sectionArray = [[NSMutableArray alloc] initWithObjects:@"Metals & Minerals",@"Rail",@"Infrastructure",@"Industrial-AirX",@"Industrial-PK",@"Industrial-IKG", nil];
    
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



-(void)viewWillAppear:(BOOL)animated
{
    // Metals
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"METALSACTIVECOMP"] == nil)
    {
        [divisionDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"METALSDEFAULTCOMP"] forKey:[sectionArray objectAtIndex:0]];
    }
    else 
    {
        [divisionDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"METALSACTIVECOMP"] forKey:[sectionArray objectAtIndex:0]];
    }
    
    //Rail
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"RAILACTIVECOMP"] == nil)
    {
        [divisionDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"RAILDEFAULTCOMP"] forKey:[sectionArray objectAtIndex:1]];
    }
    else 
    {
        [divisionDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"RAILACTIVECOMP"] forKey:[sectionArray objectAtIndex:1]];
    }
    
    
    //Infrastructure
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"INFRAACTIVECOMP"] == nil)
    {
        [divisionDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"INFRADEFAULTCOMP"] forKey:[sectionArray objectAtIndex:2]];
    }
    else 
    {
        [divisionDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"INFRAACTIVECOMP"] forKey:[sectionArray objectAtIndex:2]];
    }
    
    //Industrial
    
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"INDAIRXACTIVECOMP"] == nil)
    {
        [divisionDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"INDAIRXDEFAULTCOMP"] forKey:[sectionArray objectAtIndex:3]];
    }
    else 
    {
        [divisionDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"INDAIRXACTIVECOMP"] forKey:[sectionArray objectAtIndex:3]];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"INDACTIVECOMP"] == nil)
    {
        [divisionDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"INDDEFAULTCOMP"] forKey:[sectionArray objectAtIndex:4]];
    }
    else 
    {
        [divisionDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"INDACTIVECOMP"] forKey:[sectionArray objectAtIndex:4]];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"INDIKGACTIVECOMP"] == nil)
    {
        [divisionDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"INDIKGDEFAULTCOMP"] forKey:[sectionArray objectAtIndex:5]];
    }
    else 
    {
        [divisionDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"INDIKGACTIVECOMP"] forKey:[sectionArray objectAtIndex:5]];
    }
    
    
    dataArray = [[NSMutableArray alloc] initWithObjects:@"BIS",@"Hertel",@"Safway",@"Doka",@"Efco",@"Lavendon",@"PERI",@"RMD",@"ULMA",@"Layher",@"Cape IS", nil];
    
    [competitorTable reloadData];
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


#pragma mark TableView methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sectionArray count];
    
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [sectionArray objectAtIndex:section];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[divisionDict objectForKey:[sectionArray objectAtIndex:section]] count];
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
    cell.textLabel.text = [[divisionDict objectForKey:[sectionArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    //cell.textLabel.text = @"mahi";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    newsItemsVC* newsitemsVC = [[newsItemsVC alloc] init];
    
    newsitemsVC.rssFeedTopic = [[divisionDict objectForKey:[sectionArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    
    [self presentModalViewController:newsitemsVC animated:YES];
    
    [newsitemsVC release];
        
}


@end
