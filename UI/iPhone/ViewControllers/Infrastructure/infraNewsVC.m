//
//  infraNewsVC.m
//  Germanium
//
//  Created by SadikAli on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "infraNewsVC.h"

@interface infraNewsVC ()

@end

@implementation infraNewsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"competitorNewsVC" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.newsHeader.topItem.title = @"Infrastructure News";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    //    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    
    return YES;
}



-(void)fetchRSSFeed
{
     [self.spinningIndicator startAnimating];
    RSSParser* parser = [[RSSParser alloc] init];
    parser.delegate = self;
    
    [parser fetchRssFeedFromURL:@"http://news.google.com/news?um=1&ned=us&hl=en&q=HarscoInfrastructure&output=rss"];
}

@end
