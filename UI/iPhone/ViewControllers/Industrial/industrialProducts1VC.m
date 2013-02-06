//
//  industrialProducts1VC.m
//  Germanium
//
//  Created by SadikAli on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "industrialProducts1VC.h"

@implementation industrialProducts1VC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Products";
    //self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    CGFloat nRed=26.0/255.0; 
    CGFloat nBlue=78/255.0;
    CGFloat nGreen=134.0/255.0;
    UIColor *myColor=[[UIColor alloc]initWithRed:nRed green:nBlue blue:nGreen alpha:1];
    
    self.navigationController.navigationBar.tintColor = myColor;
    [myColor release];
    
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
    
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    //section text as a label
//    UILabel *sectionHead = [[UILabel alloc] init];
//    
//   
//    sectionHead.text = @"test"; 
//    sectionHead.font = [UIFont boldSystemFontOfSize:24];
//    sectionHead.textColor = [UIColor whiteColor];
//    sectionHead.backgroundColor = [UIColor grayColor];
//    
//    return sectionHead;
//    
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//	
//    
//    return [feedBackCaptions objectAtIndex: section];
//}

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
    [self configureCell:(Default_TableCell*)cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(Default_TableCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_item_bg.png"]];
     cell.cellImage.image = [UIImage imageNamed:[[imageArray objectAtIndex:indexPath.row] stringByAppendingFormat:@".jpg"]];
    cell.cellText.text = [productTitles objectAtIndex:indexPath.row];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    /* industrialProductsDetailVC *detailViewController = [[industrialProductsDetailVC alloc] initWithKey:[imageArray objectAtIndex:indexPath.row]];
    if(indexPath.row == 3)
    {
        detailViewController.title = @"Mebac®";
    }
    else if(indexPath.row == 4)
    {
        detailViewController.title = @"HIG GrateCoat";
    }
    else
    {
        detailViewController.title = [productTitles objectAtIndex:indexPath.row];
    }
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];*/
    
    
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
