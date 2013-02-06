//
//  metalsHDInnovationsVC.m
//  Germanium
//
//  Created by SadikAli on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "metalsHDInnovationsVC.h"

@interface metalsHDInnovationsVC ()

@end

@implementation metalsHDInnovationsVC

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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    [self configureCell:cell atIndexPath:indexPath];
	return cell;
}

- (void)configureCell:(Default_HDTableCell *)cell atIndexPath:(NSIndexPath *)indexPath 
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


@end
