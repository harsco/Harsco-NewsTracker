//
//  infraProductsVC.m
//  Germanium
//
//  Created by SadikAli on 1/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "infraProductsVC.h"

@implementation infraProductsVC
@synthesize infrastructureHeader;

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
    self.infrastructureHeader.topItem.leftBarButtonItem = backButton;
    
    productsArray = [[NSMutableArray alloc] initWithObjects:@"Formwork and Shoring",@"Scaffolding",@"Mechanical Access",@"Site and Safety",@"Roofing and Shelters", nil];

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



#pragma mark -TableView Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [productsArray count];
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
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_item_bg.png"]];
    cell.cellImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d%@",@"infra",indexPath.row,@".jpg"]];
    cell.cellText.text = [productsArray objectAtIndex:indexPath.row];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        industrialProductsWebVC* productsVC = [[industrialProductsWebVC alloc] initWithURLString:@"http://www.harsco-i.com/product_range/formwork_shoring"];
        productsVC.productTitle = [productsArray objectAtIndex:indexPath.row];
        [self presentModalViewController:productsVC animated:YES];
        [productsVC release];
    }
    else if(indexPath.row == 1)
    {
        industrialProductsWebVC* productsVC = [[industrialProductsWebVC alloc] initWithURLString:@"http://www.harsco-i.com/product_range/scaffolding"];
        productsVC.productTitle = [productsArray objectAtIndex:indexPath.row];
        [self presentModalViewController:productsVC animated:YES];
        [productsVC release];
    }
    else if(indexPath.row == 2)
    {
        industrialProductsWebVC* productsVC = [[industrialProductsWebVC alloc] initWithURLString:@"http://www.harsco-i.com/product_range/mechanical_access"];
        productsVC.productTitle = [productsArray objectAtIndex:indexPath.row];
        [self presentModalViewController:productsVC animated:YES];
        [productsVC release];
    }
    else if(indexPath.row == 3)
    {
        industrialProductsWebVC* productsVC = [[industrialProductsWebVC alloc] initWithURLString:@"http://www.harsco-i.com/product_range/site_safety"];
        productsVC.productTitle = [productsArray objectAtIndex:indexPath.row];
        [self presentModalViewController:productsVC animated:YES];
        [productsVC release];
    }
    else if(indexPath.row == 4)
    {
        industrialProductsWebVC* productsVC = [[industrialProductsWebVC alloc] initWithURLString:@"http://www.harsco-i.com/product_range/roofing_shelters"];
        productsVC.productTitle = [productsArray objectAtIndex:indexPath.row];
        [self presentModalViewController:productsVC animated:YES];
        [productsVC release];
    }
}

#pragma mark-action methods
#pragma mark - Action Methods
-(void)onHomeClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
