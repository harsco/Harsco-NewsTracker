//
//  indHDAXCProducts.m
//  Germanium
//
//  Created by SadikAli on 9/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "indHDAXCProducts.h"

@interface indHDAXCProducts ()

@end

@implementation indHDAXCProducts

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
    // Set up the cell...
    [self configureCell:(Default_HDTableCell*)cell atIndexPath:indexPath];
    
    return cell;
    
}

- (void)configureCell:(Default_HDTableCell *)cell atIndexPath:(NSIndexPath *)indexPath 
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


@end
