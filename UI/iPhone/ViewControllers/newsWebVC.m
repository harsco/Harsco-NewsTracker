//
//  newsWebVC.m
//  Germanium
//
//  Created by SadikAli on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "newsWebVC.h"

@interface newsWebVC ()

@end

@implementation newsWebVC

@synthesize newsHeader;
@synthesize webView;
@synthesize url;
@synthesize webActivityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id)initWithURLString:(NSString*)urlstring
{
    if(self = [super init])
    {
        self.url = [[NSString alloc] initWithString:urlstring];
        NSLog(@"string is %@",urlstring);
        
        
    }
    
    return self;
       
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
    
    if(!([error code] == -999))
        
        [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:[error localizedDescription]];
    //[App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:[error localizedDescription]];
    
}

#pragma mark-action methods
#pragma mark - Action Methods
-(void)onHomeClick:(id)sender
{
     [self.webView setDelegate:nil];
    [self dismissModalViewControllerAnimated:YES];
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
    self.newsHeader.topItem.leftBarButtonItem = backButton;
    
    [self.webActivityIndicator startAnimating];
    
    [self.webView loadRequest:
     [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]
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
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

@end
