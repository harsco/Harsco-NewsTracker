//
//  metalsHDCustomers.m
//  Germanium
//
//  Created by SadikAli on 9/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "metalsHDCustomers.h"

@interface metalsHDCustomers ()

@end

@implementation metalsHDCustomers

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"editableHDTable" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    dataArray = [[NSMutableArray alloc] initWithObjects:@"Verizon",@"Cisco",nil];
    
   NSMutableArray* defaultArray = [[NSMutableArray alloc] initWithObjects:@"ESI",@"ANIE",@"ArcelorMittal",@"Outokumpu",@"IspatIndustries",@"Lucchini",@"Tata Steel Group",@"US Steel",@"Gerdau",@"Bluescope Steel",@"Celsa Steel",@"Nucor",@"ThyssenKrupp",@"OneSteel",@"Usiminas",@"Allegheny Ludlum Corp",@"AK Steel",@"North American Stainless",nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:defaultArray forKey:@"METALSDEFAULTCUST"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"METALSACTIVECUST"] == nil)
    {
        dataArray = [[NSMutableArray alloc] initWithArray:defaultArray];
    }
    else 
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"METALSACTIVECUST"]];
    }
    
    self.newsHeader.topItem.title = @"Customers";
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"METALSACTIVECUST"] == nil)
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"METALSDEFAULTCUST"]];
    }
    else 
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"METALSACTIVECUST"]];
    }
    
    [self.editableTable reloadData];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	assert(editingStyle == UITableViewCellEditingStyleDelete);
	assert(indexPath.section == 0);
	[dataArray removeObjectAtIndex:indexPath.row];
    NSLog(@"dataArray count is %d",[dataArray count]);
    [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"METALSACTIVECUST"];
    
    //	if (![dataArray count]) {
    //		[self.editableTable deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationRight];
    //	} else {
    //		[self.editableTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    //	}
    //    
    
    [self.editableTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    
	[self addButtons:self.editableTable.editing];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    newsItemsHDVC* newsitemsVC = [[newsItemsHDVC alloc] init];
    
    if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Celsa Steel"])
    {
        //newsitemsVC.rssFeedTopic = @"\"CelsaSteel\"";
        newsitemsVC.rssFeedTopic = @"CelsaSteel";
        NSLog(@"string is %@",newsitemsVC.rssFeedTopic);
    }
    else
    {
        newsitemsVC.rssFeedTopic = [[dataArray objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@" " withString:@""]; 
    }
    
    
    [self presentModalViewController:newsitemsVC animated:YES];
    
    [newsitemsVC release];

    
    
}


@end
