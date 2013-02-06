//
//  indHDAXCCustomers.m
//  Germanium
//
//  Created by Mahi on 9/24/12.
//
//

#import "indHDAXCCustomers.h"

@interface indHDAXCCustomers ()

@end

@implementation indHDAXCCustomers

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
    
    NSMutableArray* defaultArray = [[NSMutableArray alloc] initWithObjects:@"Exterran",@"Enerflex",@"Chesapeake Energy",@"Caterpillar",@"SEC",@"CDM Resource Management",@"Dearing Compressor and Pump",@"AG Equipment",@"Valerus",@"Spitzer Industries Inc",@"Cameron",nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:defaultArray forKey:@"INDDEFAULTCUST"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"INDACTIVECUST"] == nil)
    {
        dataArray = [[NSMutableArray alloc] initWithArray:defaultArray];
    }
    else
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"INDACTIVECUST"]];
    }
    
    
    self.newsHeader.topItem.title = @"Customers";
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"INDACTIVECUST"] == nil)
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"INDDEFAULTCUST"]];
    }
    else
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"INDACTIVECUST"]];
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
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	assert(editingStyle == UITableViewCellEditingStyleDelete);
	assert(indexPath.section == 0);
	[dataArray removeObjectAtIndex:indexPath.row];
    NSLog(@"dataArray count is %d",[dataArray count]);
    [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"INDACTIVECUST"];
    
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
    
    if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"SEC"])
    {
        newsitemsVC.rssFeedTopic = @"SuperiorEnergyCompany";
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Cameron"])
    {
        newsitemsVC.rssFeedTopic = @"Cameron+oil+gas";
    }
    
    else
    {
        newsitemsVC.rssFeedTopic = [[dataArray objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
    }
    
    
    [self presentModalViewController:newsitemsVC animated:YES];
    
    [newsitemsVC release];
    
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 1)
    {
        
        if (![[myTextField text] length])
            return;
        
        if (![dataArray containsObject:[myTextField text]]) {
            [dataArray addObject:[myTextField text]];
            [dataArray sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"INDACTIVECUST"];
        }
        
        [self addButtons:self.editableTable.editing];
        [self.editableTable reloadData];
        NSUInteger ints[2] = {1,[dataArray indexOfObject:[myTextField text]]};
        NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ints length:2];
        // [self.editableTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
}

@end
