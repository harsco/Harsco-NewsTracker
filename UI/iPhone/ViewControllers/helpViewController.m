//
//  helpViewController.m
//  Germanium
//
//  Created by SadikAli on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "helpViewController.h"

@implementation helpViewController
@synthesize helpView;
@synthesize helpHeader;

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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[helpView loadRequest:
    // [NSURLRequest requestWithURL:[NSURL URLWithString:@"test.html"]
            //          cachePolicy:NSURLCacheStorageAllowed
            //      timeoutInterval:60]];
    
    UIImage* image = [UIImage imageNamed:@"app_btn_back"];
    CGRect frameimg = CGRectMake(0, 0, image.size.width, image.size.height);
    
    UIButton *button = [[UIButton alloc] initWithFrame:frameimg];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onHomeClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backButton =[[UIBarButtonItem alloc] initWithCustomView:button];
    self.helpHeader.topItem.leftBarButtonItem = backButton;

    
    [self loadHelpPage];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


-(void)loadHelpPage
{
    [self.helpView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"]isDirectory:NO]]];
}

#pragma mark-action methods
#pragma mark - Action Methods
-(void)onHomeClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


@end
