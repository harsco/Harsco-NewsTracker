//
//  indHDPKHomeVC.m
//  Germanium
//
//  Created by SadikAli on 9/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "indHDPKHomeVC.h"

@interface indHDPKHomeVC ()

@end

@implementation indHDPKHomeVC

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
     self.railHeader.topItem.title = @"Patterson-Kelley";
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
    
    [self.railWebView loadRequest:
     [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.harscopk.com/"]
                      cachePolicy:NSURLCacheStorageAllowed
                  timeoutInterval:60]];
}

@end
