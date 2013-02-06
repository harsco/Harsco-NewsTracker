//
//  baseHDWebview.m
//  Germanium
//
//  Created by SadikAli on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "baseHDWebview.h"

@interface baseHDWebview ()

@end

@implementation baseHDWebview

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
    
    [self loadRequest];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


#pragma mark - Action Methods
-(void)onHomeClick:(id)sender
{
    [self.railWebView setDelegate:nil];
    
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
    
    NSLog(@"error is %d",[error code]);
    
    if(!([error code] == -999))
    
    [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:[error localizedDescription]];
}


-(void)loadRequest
{
//    [self.railWebView loadRequest:
//     [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.harscorail.com/"]
//                      cachePolicy:NSURLCacheStorageAllowed
//                  timeoutInterval:60]];
}



@end
