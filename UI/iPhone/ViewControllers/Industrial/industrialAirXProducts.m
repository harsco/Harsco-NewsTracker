//
//  industrialAirXProducts.m
//  Germanium
//
//  Created by SadikAli on 1/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "industrialAirXProducts.h"

@implementation industrialAirXProducts

@synthesize header;

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

#pragma mark - View lifecycle

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
    self.header.topItem.leftBarButtonItem = backButton;
    
    productTitles = [[NSMutableArray alloc] initWithObjects:@"Gas Compression Systems",@"Process Cooling Systems",@"Lube Oil Cooling Systems", nil];
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
    //    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    
    return YES;
}

#pragma mark-action methods
#pragma mark - Action Methods
-(void)onHomeClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [productTitles count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
           // Set up the cell...
        [self configureCell:(Default_TableCell*)cell atIndexPath:indexPath];
        
        return cell;
    
}

- (void)configureCell:(Default_TableCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_item_bg.png"]];
    
    switch (indexPath.row) {
        case 0:
             cell.cellImage.image = [UIImage imageNamed:@"airx1.jpg"];
            break;
        case 1:
            cell.cellImage.image = [UIImage imageNamed:@"airx2.jpg"];
            break;
        case 2:
            cell.cellImage.image = [UIImage imageNamed:@"airx3.jpg"];
            break;
        default:
            break;
    }
   
    cell.cellText.text = [productTitles objectAtIndex:indexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        industrialProductsWebVC* vc = [[industrialProductsWebVC alloc] initWithURLString:@"http://www.harscoaxc.com/product-showroom/detail.aspx?id=1005"];
        
        vc.productTitle = @"Gas Compression Systems";
        
        [self presentModalViewController:vc animated:YES];
    }
    else if(indexPath.row == 1)
    {
        industrialProductsWebVC* vc = [[industrialProductsWebVC alloc] initWithURLString:@"http://www.harscoaxc.com/product-showroom/detail.aspx?id=1006"];
        
        vc.productTitle = @"Process Cooling Systems";
       // vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        
        [self presentModalViewController:vc animated:YES];
    }
    else if(indexPath.row == 2)
    {
        industrialProductsWebVC* vc = [[industrialProductsWebVC alloc] initWithURLString:@"http://www.harscoaxc.com/product-showroom/detail.aspx?id=1007"];
        
        vc.productTitle = @"Lube Oil Cooling Systems";
        
        [self presentModalViewController:vc animated:YES];
    }
}
@end
