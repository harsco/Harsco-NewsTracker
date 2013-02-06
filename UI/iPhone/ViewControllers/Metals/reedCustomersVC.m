//
//  reedCustomersVC.m
//  Germanium
//
//  Created by SadikAli on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "reedCustomersVC.h"

@interface reedCustomersVC ()

@end

@implementation reedCustomersVC

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
    sectionArray = [[NSMutableArray alloc] initWithObjects:@"Key Roofing Customers",@"Key Abrasives Customers", nil];
    
    NSMutableArray* temp = [[NSMutableArray alloc] initWithObjects:@"GAF MATERIALS CORP",@"OWENS CORNING POSTPETITION-PAR",@"CERTAINTEED CORPORATION",@"CARLISLE COATINGS & WATERPROOF",@"NORTHERN ELASTOMERIC INC",@"TAMKO ROOFING",@"POLYGLASS USA",@"BITEC INC",@"TARCO OF TEXAS INC  PARENT",@"U S PLY INC",@"OWENS CORNING POSTPETITION",@"HDQ",@"ABH ENTERPRISES INC",@"GAF MATERIALS CORP",@"G A P ROOFING INC",@"WRIGHT ASPHALT PRODUCTS; CHANN",@"CERTAINTEED CORPORATION - HDQT" ,@"ABH ENTERPRISES INC",@"GAF MATERIALS CORP - HDQTRS-BR",@"G A P ROOFING INC",@"WRIGHT ASPHALT PRODUCTS; CHANN",@"CERTAINTEED CORPORATION - HDQT",nil];
    
    [divisionDict setObject:temp forKey:@"Key Roofing Customers"];
    
    NSMutableArray* temp1 = [[NSMutableArray alloc] initWithObjects:@"MARCO GROUP-PARENT",@"MOHAWK MATERIALS CO INC - PARE",@"F&S EQUIPMENT-PARENT",@"UTILITY SERVICE CO INC-PARENT",@"CLEMTEX - POSTPETITION - HQTRS",@"SURFACE PREP SUPPLY-PARENT",@"PORTER WARNER IND- PARENT",@"PINNACLE CENTRAL-PARENT",@"SHERWIN-WILLIAMS PARENT",@"CAROLINA EQUIPMENT-CHARLESTON",@"CALUMITE COMPANY - PORTAGE - H",@"FLAT ROCK BAGGING BILL",@"WEST VIRGINIA PAINT-CLIFTON NJ",@"R & D SUPPLY",@"A H HARRIS & SONS- WEST HARTFO",@"APC EQUIPMENT & SUPPLY --NORFO",@"BLAST-ONE INTERNATIONAL", nil];
    
    [divisionDict setObject:temp1 forKey:@"Key Abrasives Customers"];
    
    [temp release];
    [temp1 release];
    
    self.newsHeader.topItem.title = @"Customers";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    
    return YES;
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
    
    if([[[divisionDict objectForKey:[sectionArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] isEqualToString:@"GAF MATERIALS CORP"])
    {
        newsitemsVC.rssFeedTopic = @"GafMaterialsCorp+roofing";
        [self presentModalViewController:newsitemsVC animated:YES];
        [newsitemsVC release];
    }
    else if([[[divisionDict objectForKey:[sectionArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] isEqualToString:@"POLYGLASS USA"])
    {
        newsitemsVC.rssFeedTopic = @"PolyglassUSA+roofing";
        [self presentModalViewController:newsitemsVC animated:YES];
        [newsitemsVC release];
    }
        
    
    else
    {
        newsitemsVC.rssFeedTopic = [[divisionDict objectForKey:[sectionArray objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        
        [self presentModalViewController:newsitemsVC animated:YES];
        
        [newsitemsVC release];
    }
    
    
       
}


@end
