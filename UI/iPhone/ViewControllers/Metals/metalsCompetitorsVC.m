//
//  metalsCompetitorsVC.m
//  Germanium
//
//  Created by SadikAli on 5/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "metalsCompetitorsVC.h"

@interface metalsCompetitorsVC ()

@end

@implementation metalsCompetitorsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"editableTableVC" bundle:nibBundleOrNil];
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
    
    NSMutableArray* defaultArray = [[NSMutableArray alloc] initWithObjects:@"TubeCity",@"Phoenix",@"AbrasivesInc",@"Dupont/Starblast",@"Ervin Industries",@"GMA Garnet (USA) Corporation",@"Green Diamond Sand Product",@"Mobile Abrasives",@"Newageblastmedia",@"Opta Minerals, Inc. ",@"U.S. Minerals",@"W Abrasives/ Pan Abrasives", nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:defaultArray forKey:@"METALSDEFAULTCOMP"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"METALSACTIVECOMP"] == nil)
    {
        dataArray = [[NSMutableArray alloc] initWithArray:defaultArray];
    }
    else 
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"METALSACTIVECOMP"]];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
   
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"METALSACTIVECOMP"] == nil)
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"METALSDEFAULTCOMP"]];
    }
    else 
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"METALSACTIVECOMP"]];
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
    // return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    
    return YES;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	assert(editingStyle == UITableViewCellEditingStyleDelete);
	assert(indexPath.section == 0);
	[dataArray removeObjectAtIndex:indexPath.row];
    NSLog(@"dataArray count is %d",[dataArray count]);
    [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"METALSACTIVECOMP"];
    
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
    newsItemsVC* newsitemsVC = [[newsItemsVC alloc] init];
    
    if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Phoenix"])
    {
        newsitemsVC.rssFeedTopic = @"PhoenixSteelServices";
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
            [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"METALSACTIVECOMP"];
        }
        
        [self addButtons:self.editableTable.editing];
        [self.editableTable reloadData];
        NSUInteger ints[2] = {1,[dataArray indexOfObject:[myTextField text]]};
        NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ints length:2];
       // [self.editableTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
}

@end
