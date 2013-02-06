//
//  indHDPKCompetitors.m
//  Germanium
//
//  Created by Mahi on 9/24/12.
//
//

#import "indHDPKCompetitors.h"

@interface indHDPKCompetitors ()

@end

@implementation indHDPKCompetitors

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
    
    NSMutableArray* defaultArray = [[NSMutableArray alloc] initWithObjects:@"Aerco",@"Ajax Boiler",@"American Standard",@"AO Smith",@"Bradford White",@"Bryan Boilers",@"Buderus",@"Camus",@"Cemline",@"Cleaver Brooks",@"DeDietrich",@"Emerson",@"Fulton",@"Honeywell",@"HTP",@"Hurst Boiler",@"Hydrotherm",@"Johnson Controls",@"Laars",@"Lochinvar",@"Mestek, Inc",@"Noritz",@"Parker Boiler",@"Peerless Boiler",@"PVI",@"Raypak",@"RBI",@"Rheem",@"Rinnai",@"Ruud",@"Sellers Engineering",@"Thermal Solutions",@"Viessman",@"Weil McClain",@"York", nil];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:defaultArray forKey:@"INDDEFAULTCOMP"];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"INDACTIVECOMP"] == nil)
    {
        dataArray = [[NSMutableArray alloc] initWithArray:defaultArray];
    }
    else
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"INDACTIVECOMP"]];
    }
    
    
    self.newsHeader.topItem.title = @"Competitors";
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"INDACTIVECOMP"] == nil)
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"INDDEFAULTCOMP"]];
    }
    else
    {
        dataArray = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"INDACTIVECOMP"]];
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
    [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"INDACTIVECOMP"];
    
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
    
    if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Camus"])
    {
        newsitemsVC.rssFeedTopic = @"CamusHydronicsLTD";
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Fulton"])
    {
        newsitemsVC.rssFeedTopic = @"Fulton+commercialboilers";
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"York"])
    {
        newsitemsVC.rssFeedTopic = @"York-ShipleyGlobal";
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Rheem"])
    {
        newsitemsVC.rssFeedTopic = @"Rheem+heating+cooling+waterproducts";
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"RBI"])
    {
        newsitemsVC.rssFeedTopic = @"RBI+waterheater";
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Raypak"])
    {
        newsitemsVC.rssFeedTopic = @"Raypak+boilers";
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"Laars"])
    {
        newsitemsVC.rssFeedTopic = @"Laars+boilers";
    }
    else if([[dataArray objectAtIndex:indexPath.row] isEqualToString:@"HTP"])
    {
        newsitemsVC.rssFeedTopic = @"HTP+boilers";
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
            [[NSUserDefaults standardUserDefaults] setObject:dataArray forKey:@"INDACTIVECOMP"];
        }
        
        [self addButtons:self.editableTable.editing];
        [self.editableTable reloadData];
        NSUInteger ints[2] = {1,[dataArray indexOfObject:[myTextField text]]};
        NSIndexPath* indexPath = [NSIndexPath indexPathWithIndexes:ints length:2];
        // [self.editableTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
}


@end
