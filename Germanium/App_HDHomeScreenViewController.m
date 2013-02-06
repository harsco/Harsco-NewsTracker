//
//  App_HDHomeScreenViewController.m
//  Germanium
//
//  Created by SadikAli on 9/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "App_HDHomeScreenViewController.h"

@interface App_HDHomeScreenViewController ()

@end

@implementation App_HDHomeScreenViewController
@synthesize railHDTab;
@synthesize metalsHDTab;
@synthesize infrastructureHDTab;
@synthesize indHDIKGTab;
@synthesize indHDPKTab;
@synthesize indHDAXCTab;
@synthesize feedbackHDNavVC;
@synthesize landscapeView;

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
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
     [self.stockLabel1 setFont: [UIFont fontWithName:@"Verdana-BoldItalic" size:16]];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}


#pragma mark orientation
- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
      
    if (UIDeviceOrientationIsLandscape(deviceOrientation) &&
        !isShowingLandscapeView)
    {
          
        [self.view addSubview:self.landscapeView];
        
        self.stockLabel2.alpha = 0;
        self.stockLabel2.transform = CGAffineTransformIdentity;
        
        self.stockLabel2.text = [[newsArticles objectAtIndex:0] objectForKey:@"title"];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:5];
        [UIView setAnimationRepeatCount:1000];
        //makes text fade in to solid
        self.stockLabel2.alpha = 1;
        self.stockLabel2.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
        [UIView commitAnimations];
        
        isShowingLandscapeView = YES;
        
    }
    else if (UIDeviceOrientationIsPortrait(deviceOrientation) &&
             isShowingLandscapeView)
    {
                
        [self.landscapeView removeFromSuperview];
        self.landscapeView = nil;
        isShowingLandscapeView = NO;
    }
}


#pragma mark- custom getters

- (UITabBarController *)railHDTab {
	if (railHDTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"railTabHDController" owner:self options:nil];
        railHDTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        railHDTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return railHDTab;
}

- (UITabBarController *)metalsHDTab {
	if (metalsHDTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"metalsHDTab" owner:self options:nil];
        metalsHDTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        metalsHDTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return metalsHDTab;
}

- (UITabBarController *)indHDIKGTab {
	if (indHDIKGTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"indHDIKGTab" owner:self options:nil];
        indHDIKGTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        indHDIKGTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return indHDIKGTab;
}

- (UITabBarController *)indHDPKTab {
	if (indHDPKTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"indHDPKTab" owner:self options:nil];
        indHDPKTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        indHDPKTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return indHDPKTab;
}

- (UITabBarController *)indHDAXCTab {
	if (indHDAXCTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"indHDAXCTab" owner:self options:nil];
        indHDAXCTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        indHDAXCTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return indHDAXCTab;
}

- (UITabBarController *)infrastructureHDTab {
	if (infrastructureHDTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"infrastructureHDTab" owner:self options:nil];
        infrastructureHDTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        infrastructureHDTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return infrastructureHDTab;
}

- (UITabBarController *)RSSTab {
	if (RSSTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"RSSTab" owner:self options:nil];
        RSSTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        RSSTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return RSSTab;
}


-(UINavigationController *)feedbackHDNavVC
{
    if(feedbackHDNavVC == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"feedbackHDNavVC" owner:self options:nil];
        feedbackHDNavVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        feedbackHDNavVC.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return feedbackHDNavVC;
}



-(UIView*)landscapeView
{
    if(landscapeView == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"LandscapeHD" owner:self options:nil];
        
    }
    
    return landscapeView;
}

-(IBAction)railButtonClicked:(id)sender
{
    //railDivisionViewController* railDivisionScreen = [[railDivisionViewController alloc] init];
    self.railHDTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:self.railHDTab animated:YES];
    // [self presentModalViewController:railDivisionScreen animated:YES];
    // [railDivisionScreen release];
}

-(IBAction)metalsButtonClicked:(id)sender
{
    self.metalsHDTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //self.metalsTab.
    [self presentModalViewController:self.metalsHDTab animated:YES];
}

-(IBAction)infraButtonClicked:(id)sender
{
    //[App_GeneralUtilities showAlertOKWithTitle:@"Harsco Infrastructure" withMessage:@"ComingSoon!!"];
    self.infrastructureHDTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:self.infrastructureHDTab animated:YES];
}

-(IBAction)onFeedBackClicked:(id)sender
{
    // [App_GeneralUtilities showAlertOKWithTitle:@"Feedback" withMessage:@"ComingSoon!!"];
//    SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
//    testMsg.fromEmail = @"test@harsco.com";
//    testMsg.toEmail = @"mnimishakavi@harsco.com";
//    //testMsg.relayHost = @"smtp.harsco.com";
//    testMsg.relayHost = @"smtp.mac.com";
//    testMsg.requiresAuth = NO;
//    testMsg.login = @"test@test.com";
//    testMsg.pass = @"testpassword";
//    testMsg.subject = @"test message";
//    testMsg.bccEmail = @"testbcc@test.com";
//    testMsg.wantsSecure = NO; // smtp.gmail.com doesn't work without TLS!
//    
//    // Only do this for self-signed certs!
//    // testMsg.validateSSLChain = NO;
//    testMsg.delegate = self;
//    
//    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
//                               @"This is a test message.",kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
//    
//    // NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"vcf"];
//    // NSData *vcfData = [NSData dataWithContentsOfFile:vcfPath];
//    
//    /*NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"test.vcf\"",kSKPSMTPPartContentTypeKey,
//     @"attachment;\r\n\tfilename=\"test.vcf\"",kSKPSMTPPartContentDispositionKey,[vcfData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];*/
//    
//    testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
//    
//    //[testMsg send];
//    
//    
//    
//    [self presentModalViewController:self.feedbackHDNavVC animated:YES];
    
    
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    
    //[mailController setSubject:@"Feedback"];
   // [mailController setMessageBody:@"my message" isHTML:NO];
    [mailController setToRecipients:[NSArray arrayWithObjects:@"harscosocialmedia@harsco.com", nil]];
    
    mailController.mailComposeDelegate = self;
    
        
    if ( mailController != nil ) {
        if ([MFMailComposeViewController canSendMail]){
            [self presentModalViewController:mailController animated:YES];
        }
    }
    
    [mailController release];
    
    
}



-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissModalViewControllerAnimated:YES];
    
//    if(result == MFMailComposeResultSent)
//    {
//        [App_GeneralUtilities showAlertOKWithTitle:@"Success!!" withMessage:@"Feedback sent successfully to harscosocialmedia@harsco.com"];
//    }
}

-(IBAction)onSettingsClicked:(id)sender
{
    NSLog(@"hai");
    settingsHDVC* settingsViewController = [[settingsHDVC alloc] init];
    
    [self presentModalViewController:settingsViewController animated:YES];
    
    [settingsViewController release];
}


-(IBAction)onHelpClicked:(id)sender
{
    //[App_GeneralUtilities showAlertOKWithTitle:@"Help" withMessage:@"ComingSoon!!"];
    helpHDVC* helpVC = [[helpHDVC alloc] init];
    helpVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentModalViewController:helpVC animated:YES];
    
    
}


-(void)reloadAnimation
{
    //    CABasicAnimation *scrollText;
    //    
    //    scrollText=[CABasicAnimation animationWithKeyPath:@"position.x"];
    //    scrollText.duration = 6.0;
    //    scrollText.repeatCount = 10000;
    //    scrollText.autoreverses = NO;
    //    scrollText.fromValue = [NSNumber numberWithFloat:400];
    //    scrollText.toValue = [NSNumber numberWithFloat:-30.0];
    //    
    //    [[self.stockLabel1 layer] addAnimation:scrollText forKey:@"scrollTextKey"];
    
    self.stockLabel1.alpha = 0;
    self.stockLabel1.transform = CGAffineTransformIdentity;
    
    self.stockLabel1.text = [[newsArticles objectAtIndex:0] objectForKey:@"title"];
    
    // scrollText.text = [NSString stringWithFormat: @"%@", item];
    [self.stockLabel1 setFont: [UIFont fontWithName:@"Verdana-BoldItalic" size:24]];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:5];
    [UIView setAnimationRepeatCount:1000];
    //makes text fade in to solid
    self.stockLabel1.alpha = 1;
    self.stockLabel1.transform = CGAffineTransformMakeScale(1.0, 1.0);
    [UIView commitAnimations];
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if([alertView isKindOfClass:[dummyLoginView class]])
    {
        NSLog(@"return");
        return;
    }
    
    switch (buttonIndex)
    {
        case 0:
            NSLog(@"Cancel Pressed");
            break;
        case 1:
            self.indHDIKGTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentModalViewController:self.indHDIKGTab animated:YES];
            break;
        case 2:
            self.indHDAXCTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentModalViewController:self.indHDAXCTab animated:YES];
            break;
            
        case 3:
            self.indHDPKTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentModalViewController:self.indHDPKTab animated:YES];
            break;
            
        default:
            break;
    }
}



@end
