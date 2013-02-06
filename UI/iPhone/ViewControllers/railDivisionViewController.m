//
//  railDivisionViewController.m
//  Germanium
//
//  Created by SadikAli on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "railDivisionViewController.h"

@implementation railDivisionViewController
@synthesize railHeader;
@synthesize railWebView;
@synthesize webActivityIndicator;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    self.railHeader.topItem.leftBarButtonItem = backButton;
    
    self.railWebView.delegate = self;
    
    
    [self.webActivityIndicator setHidden:NO];
    [self.webActivityIndicator startAnimating];
    
        
    [self.railWebView loadRequest:
     [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.harscorail.com/"]
                      cachePolicy:NSURLCacheStorageAllowed
                  timeoutInterval:60]];
    
    
    
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
//    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
    
    return YES;
}


#pragma mark - Action Methods
-(void)onHomeClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark- webview Methods
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.webActivityIndicator stopAnimating];
    [self.webActivityIndicator setHidden:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error is %@",[error localizedDescription]);
    [self.webActivityIndicator stopAnimating];
    [self.webActivityIndicator setHidden:YES];
  //  self.railWebView.userInteractionEnabled = NO;
    
    [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:[error localizedDescription]];
}


@end
