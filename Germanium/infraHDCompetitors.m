//
//  infraHDCompetitors.m
//  Germanium
//
//  Created by SadikAli on 9/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "infraHDCompetitors.h"

@interface infraHDCompetitors ()

@end

@implementation infraHDCompetitors

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
    
    
    //dataArray = [[NSMutableArray alloc] initWithObjects:@"BIS",@"Hertel",@"Safway",@"Doka",@"Efco",@"Lavendon",@"PERI",@"RMD",@"ULMA",@"Layher",@"Cape IS", nil];
    
    NSMutableArray* defaultArray = [[NSMutableArray alloc] initWithObjects:@"BIS",@"Hertel",@"Safway",@"Doka",@"Efco",@"Lavendon",@"PERI",@"RMD",@"ULMA",@"Layher",@"Cape IS", nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:defaultArray forKey:@"INFRADEFAULTCOMP"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"INFRAACTIVECOMP"] == nil)
    {
        dataArray = [[NSMutableArray alloc] initWithArray:defaultArray];
    }
    else 
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"INFRAACTIVECOMP"]];
    }
    
    
    self.newsHeader.topItem.title = @"Competitors";
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"INFRAACTIVECOMP"] == nil)
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"INFRADEFAULTCOMP"]];
    }
    else 
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"INFRAACTIVECOMP"]];
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
    [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"INFRAACTIVECOMP"];
    
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
    
    
    NSMutableArray* defaultArray = [[NSMutableArray alloc] initWithObjects:@"BIS",@"Hertel",@"Safway",@"Doka",@"Efco",@"Lavendon",@"PERI",@"RMD",@"ULMA",@"Layher",@"Cape IS", nil];
    
    if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"BIS"])
    {
        newsitemsVC.rssFeedTopic = @"BilfingerBergerIndustrialServices";
        [self presentModalViewController:newsitemsVC animated:YES];
        
        [newsitemsVC release];
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Hertel"])
    {
        newsitemsVC.rssFeedTopic = @"HertelIndustrialServices";
        [self presentModalViewController:newsitemsVC animated:YES];
        
        [newsitemsVC release];
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Hertel"])
    {
        newsitemsVC.rssFeedTopic = @"HertelIndustrialServices";
        [self presentModalViewController:newsitemsVC animated:YES];
        
        [newsitemsVC release];
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Safway"])
    {
        newsitemsVC.rssFeedTopic = @"SafwayServices";
        [self presentModalViewController:newsitemsVC animated:YES];
        
        [newsitemsVC release];
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Doka"])
    {
        newsitemsVC.rssFeedTopic = @"TheDokaGroup";
        [self presentModalViewController:newsitemsVC animated:YES];
        
        [newsitemsVC release];
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Efco"])
    {
        newsitemsVC.rssFeedTopic = @"EFCOForms";
        [self presentModalViewController:newsitemsVC animated:YES];
        
        [newsitemsVC release];
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"PERI"])
    {
        newsitemsVC.rssFeedTopic = @"PERI+scaffolding+formwork";
        [self presentModalViewController:newsitemsVC animated:YES];
        
        [newsitemsVC release];
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"RMD"])
    {
        newsitemsVC.rssFeedTopic = @"RMDAustralia";
        [self presentModalViewController:newsitemsVC animated:YES];
        
        [newsitemsVC release];
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"ULMA"])
    {
        newsitemsVC.rssFeedTopic = @"ULMA+scaffolding";
        [self presentModalViewController:newsitemsVC animated:YES];
        
        [newsitemsVC release];
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Layher"])
    {
        newsitemsVC.rssFeedTopic = @"Layher+scaffolding";
        [self presentModalViewController:newsitemsVC animated:YES];
        
        [newsitemsVC release];
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Cape IS"])
    {
        newsitemsVC.rssFeedTopic = @"Capeplc";
        [self presentModalViewController:newsitemsVC animated:YES];
        [newsitemsVC release];
    }
    
    else
    {
        newsitemsVC.rssFeedTopic = [[dataArray objectAtIndex:indexPath.row] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        [self presentModalViewController:newsitemsVC animated:YES];
        
        [newsitemsVC release];
    }
    
    
    
    
    
    
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
            [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"INFRAACTIVECOMP"];
        }
        
        [self addButtons:self.editableTable.editing];
        [self.editableTable reloadData];
        NSUInteger ints[2] = {1,[dataArray indexOfObject:[myTextField text]]};
        NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ints length:2];
        // [self.editableTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
}



@end
