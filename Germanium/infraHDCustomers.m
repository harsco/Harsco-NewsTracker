//
//  infraHDCustomers.m
//  Germanium
//
//  Created by SadikAli on 9/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "infraHDCustomers.h"

@interface infraHDCustomers ()

@end

@implementation infraHDCustomers

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
	// Do any additional setup after loading the view.
    dataArray = [[NSMutableArray alloc] initWithObjects:@"Verizon",@"Cisco",nil];
    
    NSMutableArray* defaultArray = [[NSMutableArray alloc] initWithObjects:@"Shell",@"Tata Steel",@"Total UK Ltd.",@"Sabic Petrochemcials",@"First Energy Corporation",@"The Shaw Group",@"Genon Energy Services LLC",@"Enerfab",nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:defaultArray forKey:@"INFRADEFAULTCUST"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"INFRAACTIVECUST"] == nil)
    {
        dataArray = [[NSMutableArray alloc] initWithArray:defaultArray];
    }
    else 
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"INFRAACTIVECUST"]];
    }
    
    
    self.newsHeader.topItem.title = @"Customers";
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"INFRAACTIVECUST"] == nil)
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"INFRADEFAULTCUST"]];
    }
    else 
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"INFRAACTIVECUST"]];
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
    [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"INFRAACTIVECUST"];
    
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
    
    newsitemsVC.rssFeedTopic = [[dataArray objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
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
            [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"INFRAACTIVECUST"];
        }
        
        [self addButtons:self.editableTable.editing];
        [self.editableTable reloadData];
        NSUInteger ints[2] = {1,[dataArray indexOfObject:[myTextField text]]};
        NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ints length:2];
        // [self.editableTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
}


@end
