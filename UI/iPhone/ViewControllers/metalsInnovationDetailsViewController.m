//
//  metalsInnovationDetailsViewController.m
//  Germanium
//
//  Created by SadikAli on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "metalsInnovationDetailsViewController.h"

@implementation metalsInnovationDetailsViewController
@synthesize webActivityIndicator;
@synthesize metalHeader;
@synthesize metalsWebView;
@synthesize url;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithURLString:(NSString*)URL
{
    if(self = [super init])
    {
        self.url = [[NSString alloc] initWithString:URL];
    }
    
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
-(void)dealloc
{
    [super dealloc];
//    if([self.webActivityIndicator isAnimating])
//    {
//        [self.webActivityIndicator stopAnimating];
//    }
   // self.webActivityIndicator = nil;
   // self.metalsWebView = nil;
    //self.metalHeader = nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    
    UIImage* image = [UIImage imageNamed:@"app_btn_back"];
    CGRect frameimg = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onHomeClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.metalHeader.topItem.leftBarButtonItem = backButton;
    
    [self.webActivityIndicator setHidden:NO];
    [self.webActivityIndicator startAnimating];
    
    self.metalsWebView.delegate = self;
    
    
    [self loadWebView];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    // return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    
    return YES;
}

#pragma mark- webview Methods
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webActivityIndicator stopAnimating];
    [self.webActivityIndicator setHidden:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error is %d",[error code]);
    [self.webActivityIndicator stopAnimating];
    [self.webActivityIndicator setHidden:YES];
    self.metalsWebView.userInteractionEnabled = NO;
    
    if([error code] != -999)
    {
        [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:[error localizedDescription]];
    }
}

#pragma mark-action methods
#pragma mark - Action Methods
-(void)onHomeClick:(id)sender
{
    [self.metalsWebView setDelegate:nil];
    [self.metalsWebView stopLoading];
    if([self.webActivityIndicator isAnimating])
    {
        [self.webActivityIndicator stopAnimating];
    }
    
    webActivityIndicator = nil;
    
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void)loadWebView
{
    [self.metalsWebView loadRequest:
     [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]
                      cachePolicy:NSURLCacheStorageAllowed
                  timeoutInterval:60]];
}

@end
