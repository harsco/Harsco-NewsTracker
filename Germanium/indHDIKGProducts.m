//
//  indHDIKGProducts.m
//  Germanium
//
//  Created by SadikAli on 9/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "indHDIKGProducts.h"

@interface indHDIKGProducts ()

@end

@implementation indHDIKGProducts
@synthesize header;
@synthesize table;

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Products";
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
        
	productTitles = [[NSMutableArray alloc] initWithObjects:@"Stock Panels",@"Fabricated Grating",@"Mezzanine Grating",@"Mebac® The First Family of Slip Resistance",@"Harsco Industrial IKG GrateCoat®",@"Specialty Products",nil];
    
    imageArray = [[NSMutableArray alloc] initWithObjects:@"SP",@"FG",@"MG",@"MB",@"HIGG",@"SPD", nil];
    
    UIImage* image = [UIImage imageNamed:@"app_btn_back"];
    CGRect frameimg = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onHomeClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.header.topItem.leftBarButtonItem = backButton;

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
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
    return 120.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
	Default_HDTableCell *cell = (Default_HDTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		// Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Default_HDTableCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.accessoryView = nil;
	}
    // Set up the cell...
    [self configureCell:(Default_HDTableCell*)cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(Default_HDTableCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_item_bg.png"]];
    cell.cellImage.image = [UIImage imageNamed:[[imageArray objectAtIndex:indexPath.row] stringByAppendingFormat:@".jpg"]];
    cell.cellText.text = [productTitles objectAtIndex:indexPath.row];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    
    if(indexPath.row == 3)
    {
        
        industrialProductsWebVC* detailsVC = [[industrialProductsWebVC alloc] initWithURLString:@"http://harscoikg.com/products/detail.aspx?id=5"];
        detailsVC.productTitle = @"Mebac®";
        
        //[self.navigationController pushViewController:detailsVC animated:YES];
        
        [self presentModalViewController:detailsVC animated:YES];
        
        [detailsVC release];
        
    }
    else if(indexPath.row == 4)
    {
        industrialProductsWebVC* detailsVC = [[industrialProductsWebVC alloc] initWithURLString:@"http://harscoikg.com/products/detail.aspx?id=105"];
        detailsVC.productTitle = @"HIG GrateCoat";
        
        //[self.navigationController pushViewController:detailsVC animated:YES];
        
        [self presentModalViewController:detailsVC animated:YES];
        
        [detailsVC release];
        
    }
    else if (indexPath.row == 0)
    {
        industrialProductsWebVC* detailsVC = [[industrialProductsWebVC alloc] initWithURLString:@"http://harscoikg.com/products/detail.aspx?id=2"];
        detailsVC.productTitle = [productTitles objectAtIndex:indexPath.row];
        
        //[self.navigationController pushViewController:detailsVC animated:YES];
        
        [self presentModalViewController:detailsVC animated:YES];
        
        [detailsVC release];
    }
    else if(indexPath.row == 1)
    {
        industrialProductsWebVC* detailsVC = [[industrialProductsWebVC alloc] initWithURLString:@"http://harscoikg.com/products/detail.aspx?id=3"];
        detailsVC.productTitle = [productTitles objectAtIndex:indexPath.row];
        
        //[self.navigationController pushViewController:detailsVC animated:YES];
        
        [self presentModalViewController:detailsVC animated:YES];
        
        [detailsVC release];
    }
    else if(indexPath.row == 2)
    {
        industrialProductsWebVC* detailsVC = [[industrialProductsWebVC alloc] initWithURLString:@"http://harscoikg.com/products/detail.aspx?id=4"];
        detailsVC.productTitle = [productTitles objectAtIndex:indexPath.row];
        
        //[self.navigationController pushViewController:detailsVC animated:YES];
        
        [self presentModalViewController:detailsVC animated:YES];
        
        [detailsVC release];
    }
    else if(indexPath.row == 5)
    {
        industrialProductsWebVC* detailsVC = [[industrialProductsWebVC alloc] initWithURLString:@"http://harscoikg.com/products/detail.aspx?id=106"];
        detailsVC.productTitle = [productTitles objectAtIndex:indexPath.row];
        
        //[self.navigationController pushViewController:detailsVC animated:YES];
        
        [self presentModalViewController:detailsVC animated:YES];
        
        [detailsVC release];
    }
    
    
}

@end

