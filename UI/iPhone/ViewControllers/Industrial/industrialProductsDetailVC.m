//
//  industrialProductsDetailVC.m
//  Germanium
//
//  Created by SadikAli on 1/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "industrialProductsDetailVC.h"

@implementation industrialProductsDetailVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithKey:(NSString*)key
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self)
    {
        referenceKey = key;
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
    [pickerDataArray release];
    [stockPanels release];
    [fabricatedGrating release];
    [mebac release];
    [specialityProducts release];
    [higg release];
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    stockPanels = [[NSMutableArray alloc] initWithObjects:@"Weldforged® Steel Stock Panels",@"Swage Locked Aluminum Stock Panels" ,@"Safe-T-Grid® Aluminum Stock Panels",nil];
    
    fabricatedGrating = [[NSMutableArray alloc] initWithObjects:@"Welded Grating",@"Swage and Pressure Locked Grating",@"Stair Treads and Other Harsco Industrial IKG Gratings",@"Riveted, Roadway, and Bridge Grating", nil];
    
    mezzanineGrating = [[NSMutableArray alloc] initWithObjects:@"Weldforged® Mezzanine Grating", nil];
    
    mebac = [[NSMutableArray alloc] initWithObjects:@"Mebac® Plate Products",@"Mebac® Custom Fabricated Plate Products",@"Mebac® Surfaced Customer Materials",@"Mebac® Surface on Harsco Industrial IKG Grating",@"Mebac® Z-Treads",@"Mebac® Surfaced Rungs and Rung Covers",@"Mebac® Renovation and Embedded Nosings", nil];
    
    //higg = [[NSMutableArray  alloc] initWithObjects:<#(id), ...#>, nil
    
    specialityProducts = [[NSMutableArray alloc] initWithObjects:@"Swage Locked Grating",@"Safe-T-Grid® Aluminum Grating",@"Pressure Locked Grating",@"Heavy Duty Grating",@"Riveted, Roadway, and Bridge Grating",@"Aluminum Plank", nil];
    
     productDictionary = [[NSMutableDictionary alloc] init];
    
    [productDictionary setObject:stockPanels forKey:@"SP"];
    
    [productDictionary setObject:fabricatedGrating forKey:@"FG"];
    [productDictionary setObject:mezzanineGrating forKey:@"MG"];
    [productDictionary setObject:mebac forKey:@"MB"];
    [productDictionary setObject:specialityProducts forKey:@"SPD"];
    
    //initialize images
    
    [self initImages];
    
    
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


#pragma mark - Images

-(void)initImages
{
    if([referenceKey isEqualToString:@"SP"])
    {
        imageArray = [[NSMutableArray alloc] initWithObjects:@"SP1.jpg",@"SP2.jpg",@"SP3.jpg", nil];
    }
    else if([referenceKey isEqualToString:@"FG"])
    {
        imageArray = [[NSMutableArray alloc] initWithObjects:@"FG1.jpg",@"FG2.jpg",@"FG3.jpg",@"FG4.jpg", nil];
    }
    else if([referenceKey isEqualToString:@"MG"])
    {
        imageArray = [[NSMutableArray alloc] initWithObjects:@"MG1.jpg", nil];
    }
    else if([referenceKey isEqualToString:@"MB"])
    {
        imageArray = [[NSMutableArray alloc] initWithObjects:@"MB1.jpg",@"MB2.jpg",@"MB3.jpg",@"MB4.jpg",@"MB5.jpg",@"MB6.jpg",@"MB7.jpg", nil];
    }
    else if([referenceKey isEqualToString:@"SPD"])
    {
        imageArray = [[NSMutableArray alloc] initWithObjects:@"SPD1.jpg",@"SPD2.jpg",@"SPD3.jpg",@"SPD4.jpg",@"SPD5.jpg",@"SPD6.jpg",@"SPD7.jpg", nil];
    }
}


-(void)initPickerArray:(NSInteger)row
{
    if([referenceKey isEqualToString:@"SP"])
    {
        if(row == 0)
        {
            pickerDataArray = [[NSMutableArray alloc] initWithObjects:@"Standard Weldforged Grating",@"Heavy Duty Grating", nil];
             [self.view addSubview:pickerView];
        }
    }
    
}

#pragma mark - picker methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [pickerDataArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [pickerDataArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component 
{
	
	//NSLog(@"Selected Color: %@. Index of selected color: %i", [arrayColors objectAtIndex:row], row);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    NSLog(@"count is %d",[[productDictionary objectForKey:referenceKey] count]);
    
    return [[productDictionary objectForKey:referenceKey] count];
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
    [self configureCell:(Default_TableCell*)cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(Default_TableCell *)cell atIndexPath:(NSIndexPath *)indexPath 
{
    
    cell.cellImage.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];
    cell.cellText.text = [[productDictionary objectForKey:referenceKey] objectAtIndex:indexPath.row];
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    if(pickerView)
    [pickerView removeFromSuperview];
    
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 160, 320, 216)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    [self initPickerArray:indexPath.row];
  //  pickerView.hidden = YES;
    
   
    
    
}

@end
