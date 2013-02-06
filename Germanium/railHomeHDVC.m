//
//  railHomeHDVC.m
//  Germanium
//
//  Created by SadikAli on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "railHomeHDVC.h"

@interface railHomeHDVC ()

@end

@implementation railHomeHDVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"baseHDWebview" bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.railHeader.topItem.title = @"Rail Home";
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


-(void)loadRequest
{
    [self.railWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.harscorail.com/"] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60]];
    
   
}

@end
