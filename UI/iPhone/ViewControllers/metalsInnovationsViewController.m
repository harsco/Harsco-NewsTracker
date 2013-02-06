//
//  metalsInnovationsViewController.m
//  Germanium
//
//  Created by SadikAli on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "metalsInnovationsViewController.h"

@implementation metalsInnovationsViewController
@synthesize innovationsTable;
@synthesize metalHeader;
@synthesize dataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc
{
    [super dealloc];
    self.innovationsTable = nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.innovationsTable.delegate = self;
    
    UIImage* image = [UIImage imageNamed:@"app_btn_back"];
    CGRect frameimg = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onHomeClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.metalHeader.topItem.leftBarButtonItem = backButton;
    
    [self initVars];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
   // return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    
    return YES;
}



#pragma mark-action methods
#pragma mark - Action Methods
-(void)onHomeClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


-(void)initVars
{
    //future will initialize data source
    
    self.dataArray = [[NSMutableArray alloc] init];
    
//    [self.dataArray addObject:@"SteelFlow thin road surfacing goes further"];
//    [self.dataArray  addObject:@"LanzaTech and Harsco launch partnership"];
//    [self.dataArray  addObject:@"Converting steelmaking gas into biofuel"];
//    [self.dataArray  addObject:@"SteelStop® shows the way"];
//    [self.dataArray  addObject:@"HFS helps safety on sharp bends"];
//    [self.dataArray  addObject:@"SteelStop® launches in UK"];
//    [self.dataArray  addObject:@"Solution for refractory brick recycling"];
//    [self.dataArray  addObject:@"Harsco’s first slag asphalt road in Australia"];
//    [self.dataArray  addObject:@"Neobrita celebrates slag road in Brazil"];
//    [self.dataArray  addObject:@"Harsco 3D Innovation Blog"];
    
    [self.dataArray addObject:@"Resource Recovery"];
    [self.dataArray addObject:@"Logistics Solutions"];
    [self.dataArray addObject:@"Product Quality Solutions"];

    [self.dataArray addObject:@"By-Product Applications"];

    [self.dataArray addObject:@"Blasting Abrasives"];
    [self.dataArray addObject:@"Other Uses -  BLACK BEAUTY®"];

  //  [self.dataArray addObject:@""];

    
    
}

#pragma mark- Table View DataSource and Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	Default_TableCell *cell = (Default_TableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		// Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Default_TableCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.accessoryView = nil;
	}
    // Set up the cell...
    [self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)configureCell:(Default_TableCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{
    cell.cellText.text = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_item_bg.png"]];
    
    if(indexPath.row == 0)
    {
        cell.cellImage.image = [UIImage imageNamed:@"cellimagel1.jpg"];
    }
    else if(indexPath.row == 1)
    {
         cell.cellImage.image = [UIImage imageNamed:@"cellimagel2.jpg"];
    }
    else if(indexPath.row == 2)
    {
        cell.cellImage.image = [UIImage imageNamed:@"cellimagel3.jpg"];
    }
    else if(indexPath.row == 3)
    {
        cell.cellImage.image = [UIImage imageNamed:@"cellimagel4.jpg"];
    }

    else if(indexPath.row == 4)
    {
        cell.cellImage.image = [UIImage imageNamed:@"cellimagel5.jpg"];
    }
    else if(indexPath.row == 5)
    {
        cell.cellImage.image = [UIImage imageNamed:@"cellimagel6.jpg"];
    }
    else if(indexPath.row == 6)
    {
        cell.cellImage.image = [UIImage imageNamed:@"cellimage7.jpg"];
    }
    else if(indexPath.row == 7)
    {
        cell.cellImage.image = [UIImage imageNamed:@"cellimage8.jpg"];
    }
    else if(indexPath.row == 8)
    {
        cell.cellImage.image = [UIImage imageNamed:@"cellimage9.jpg"];
    }
    else if(indexPath.row == 9)
    {
        cell.cellImage.image = [UIImage imageNamed:@"cellimage10.jpg"];
    }


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
   
    
    if(indexPath.row == 0)
    {
        //metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://harsco3d.com/2011/11/02/new-thin-road-surfacing-goes-further/"];
        
        metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://www.harsco-m.com/19/Resource-Recovery.aspx"];
       // detailsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentModalViewController:detailsVC animated:YES];
        [detailsVC release];
    }
    else if(indexPath.row == 1)
    {
        //metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://harsco3d.com/2011/10/11/lanzatech-and-harsco-launch-partnership/"];
         metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://www.harsco-m.com/135/Logistics-Solutions.aspx"];
        
        
        [self presentModalViewController:detailsVC animated:YES];
        [detailsVC release];
    }
    else if(indexPath.row == 2)
    {
        //metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://harsco3d.com/2011/09/16/converting-steelmaking-gas-into-biofuel/"];
        
        metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://www.harsco-m.com/143/Product-Quality-Solutions.aspx"];
        
        [self presentModalViewController:detailsVC animated:YES];
        [detailsVC release];
    }
    else if(indexPath.row == 3)
    {
       // metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://harsco3d.com/2011/08/22/steelstop®-shows-the-way-in-the-uk/"];
        
        metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://www.harsco-m.com/131/By-Product-Applications.aspx"];
        
        [self presentModalViewController:detailsVC animated:YES];
        [detailsVC release];
    }
    else if(indexPath.row == 4)
    {
       // metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://harsco3d.com/2011/07/28/hfs-is-an-accident-prevention-measure/"];
        
         metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://www.harsco-m.com/145/Blasting-Abrasives.aspx"];
        
        
        
        [self presentModalViewController:detailsVC animated:YES];
        [detailsVC release];
    }
    else if(indexPath.row == 5)
    {
       // metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://harsco3d.com/2011/07/28/steelstop™-launches-in-uk/"];
        
        
        metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://www.harsco-m.com/153/Other-Uses---Black-Beauty.aspx"];
        
        
        [self presentModalViewController:detailsVC animated:YES];
        [detailsVC release];
    }
    else if(indexPath.row == 6)
    {
        metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://harsco3d.com/2011/07/25/closed-loop-refractory-brick-recycling/"];
        [self presentModalViewController:detailsVC animated:YES];
        [detailsVC release];
    }
    else if(indexPath.row == 7)
    {
        metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://harsco3d.com/2011/06/10/harscos-first-slag-asphalt-road-in-australia/"];
        [self presentModalViewController:detailsVC animated:YES];
        [detailsVC release];
    }
    else if(indexPath.row == 8)
    {
        metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://harsco3d.com/2011/05/13/neobrita-celebrates-slag-road-in-brazil/"];
        [self presentModalViewController:detailsVC animated:YES];
        [detailsVC release];
    }
    else if(indexPath.row == 9)
    {
        metalsInnovationDetailsViewController* detailsVC = [[metalsInnovationDetailsViewController alloc] initWithURLString:@"http://harsco3d.com/"];
        [self presentModalViewController:detailsVC animated:YES];
        [detailsVC release];
    }
    
}


@end
