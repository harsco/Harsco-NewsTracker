//
//  App_HomeScreen.m
//  Germanium
//
//  Created by SadikAli on 12/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "App_HomeScreen.h"

@implementation App_HomeScreen

@synthesize railTab;
@synthesize metalsTab;
@synthesize industrialTab;
@synthesize industrialAirXTab;
@synthesize industrialPKTab;
@synthesize infrastructureTab;
@synthesize RSSTab;

@synthesize feedbackNavController;

@synthesize homeScreenBackground;
@synthesize railButton;
@synthesize industrialButton;
@synthesize infrastructureButton;
@synthesize metalsButton;
@synthesize safetyButton;
@synthesize afiButton;
@synthesize blogButton;
@synthesize newsButton;
@synthesize settingsButton;

//misc buttons can be anything
@synthesize feedbackButton;
@synthesize helpButton;

@synthesize stockLabel1;
@synthesize stockLabel2;

@synthesize stockTimer;
@synthesize rssupdateTimer;
@synthesize landscapeOrientationView;


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
    self.railTab = nil;
    self.metalsTab = nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self displayStockQuote];
   // self.stockTimer = [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(displayStockQuote) userInfo:nil repeats:YES];
   
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRSS) name:@"RSSCHNGE" object:nil];
    
    isShowingLandscapeView = NO;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    
    
    if(![self.rssupdateTimer isValid])
    {
        self.rssupdateTimer = [NSTimer scheduledTimerWithTimeInterval:900.0 target:self selector:@selector(fetchRSSFeed) userInfo:nil repeats:YES];
    }
    
    
    safety = NO;
    
    RSSParser* parser = [[RSSParser alloc] init];
    parser.delegate = self;
    
    [self loadDataArrays];
    
    // [parser fetchRssFeedFromURL:@"http://news.google.com/news?um=1&ned=us&hl=en&q=harsco&output=rss"];
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"RSSFEED"] length])
    {
        
        [self showHUD:@"Fetching News Articles"];
        
        NSLog(@"url is %@",[NSString stringWithFormat:@"%@%@%@",@"http://news.google.com/news?um=1&ned=us&hl=en&q=",[[NSUserDefaults standardUserDefaults] valueForKey:@"RSSFEED"],@"output=rss"]);
        [parser fetchRssFeedFromURL:[NSString stringWithFormat:@"%@%@%@",@"http://news.google.com/news?um=1&ned=us&hl=en&q=",[[NSUserDefaults standardUserDefaults] valueForKey:@"RSSFEED"],@"&output=rss"]];
    }
    else 
    {
        [self showHUD:@"Fetching News Articles"];
        [parser fetchRssFeedFromURL:@"http://news.google.com/news?um=1&ned=us&hl=en&q=harsco&output=rss"];
    }
    newsCount = 0;
    
    
    
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    if(stockTimer)
    {
        [self.stockTimer invalidate];
        self.stockTimer =nil;
    }
    
    
    if(self.rssupdateTimer)
    {
        [self.rssupdateTimer invalidate];
        self.rssupdateTimer = nil;
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    RSSParser* parser = [[RSSParser alloc] init];
    parser.delegate = self;
    
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"ISRESET"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ISRESET"];
        
        [self showHUD:@"Fetching News Articles"];
        [parser fetchRssFeedFromURL:@"http://news.google.com/news?um=1&ned=us&hl=en&q=harsco&output=rss"];
    }

    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"RSSCHANGE"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"RSSCHANGE"];
        
        [self showHUD:@"Fetching News Articles"];
        
        NSLog(@"url is %@",[NSString stringWithFormat:@"%@%@%@",@"http://news.google.com/news?um=1&ned=us&hl=en&q=",[[NSUserDefaults standardUserDefaults] valueForKey:@"RSSFEED"],@"output=rss"]);
       [parser fetchRssFeedFromURL:[NSString stringWithFormat:@"%@%@%@",@"http://news.google.com/news?um=1&ned=us&hl=en&q=",[[NSUserDefaults standardUserDefaults] valueForKey:@"RSSFEED"],@"&output=rss"]];
    }
    
    CABasicAnimation *scrollText;
    
    scrollText=[CABasicAnimation animationWithKeyPath:@"position.x"];
    scrollText.duration = 6.0;
    scrollText.repeatCount = 10000;
    scrollText.autoreverses = NO;
    scrollText.fromValue = [NSNumber numberWithFloat:400];
    scrollText.toValue = [NSNumber numberWithFloat:-30.0];
    
   // [[self.stockLabel1 layer] addAnimation:scrollText forKey:@"scrollTextKey"];
    
    //starts text invisible
    self.stockLabel1.alpha = 0;
    self.stockLabel1.transform = CGAffineTransformIdentity;
    
    self.stockLabel1.text = [[newsArticles objectAtIndex:0] objectForKey:@"title"];
    
    self.stockLabel2.alpha = 0;
    self.stockLabel2.transform = CGAffineTransformIdentity;
    
    self.stockLabel2.text = [[newsArticles objectAtIndex:0] objectForKey:@"title"];

   // scrollText.text = [NSString stringWithFormat: @"%@", item];
    //[self.stockLabel1 setFont: [UIFont fontWithName:@"Verdana-BoldItalic" size:10]];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:5];
    [UIView setAnimationRepeatCount:1000];
    //makes text fade in to solid
    self.stockLabel1.alpha = 1;
    self.stockLabel1.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    self.stockLabel2.alpha = 1;
    self.stockLabel2.transform = CGAffineTransformMakeScale(1.0, 1.0);
    [UIView commitAnimations];
    
    
    
    
    if(![self.stockTimer isValid])
    {
          self.stockTimer = [NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(updateRSSFeed) userInfo:nil repeats:YES];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:YES];
    if([self.stockTimer isValid])
    {
        [self.stockTimer invalidate];
        self.stockTimer = nil;
        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
   // return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
    
    return YES;
}



#pragma mark orientation
- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    
    
    if (UIDeviceOrientationIsLandscape(deviceOrientation) &&
        !isShowingLandscapeView)
    {
        
        
        
        [self.view addSubview:self.landscapeOrientationView];
        
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
        
        [self.landscapeOrientationView removeFromSuperview];
        self.landscapeOrientationView = nil;
        isShowingLandscapeView = NO;
    }
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
    
    self.stockLabel2.alpha = 0;
    self.stockLabel2.transform = CGAffineTransformIdentity;
    
    self.stockLabel2.text = [[newsArticles objectAtIndex:0] objectForKey:@"title"];
    
    // scrollText.text = [NSString stringWithFormat: @"%@", item];
   // [self.stockLabel1 setFont: [UIFont fontWithName:@"Verdana-BoldItalic" size:10]];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:5];
    [UIView setAnimationRepeatCount:1000];
    //makes text fade in to solid
    self.stockLabel1.alpha = 1;
    self.stockLabel1.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    self.stockLabel2.alpha = 1;
    self.stockLabel2.transform = CGAffineTransformMakeScale(1.0, 1.0);

    
    
    [UIView commitAnimations];

}

#pragma mark- custom getters

- (UITabBarController *)railTab {
	if (railTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"railTabController" owner:self options:nil];
        railTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        railTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return railTab;
}

- (UITabBarController *)metalsTab {
	if (metalsTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"metalsTab" owner:self options:nil];
        metalsTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        metalsTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return metalsTab;
}

- (UITabBarController *)industrialTab {
	if (industrialTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"industrialTab" owner:self options:nil];
        industrialTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        industrialTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return industrialTab;
}

- (UITabBarController *)industrialAirXTab {
	if (industrialAirXTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"industrialAirXTab" owner:self options:nil];
        industrialAirXTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        industrialAirXTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return industrialAirXTab;
}

- (UITabBarController *)industrialPKTab {
	if (industrialPKTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"industrialPKTab" owner:self options:nil];
        industrialPKTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        industrialPKTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return industrialPKTab;
}

- (UITabBarController *)infrastructureTab {
	if (infrastructureTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"infrastructureTab" owner:self options:nil];
        infrastructureTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        infrastructureTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return infrastructureTab;
}

- (UITabBarController *)RSSTab {
	if (RSSTab == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"RSSTab" owner:self options:nil];
        RSSTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        RSSTab.modalPresentationStyle = UIModalPresentationFullScreen;
	}    
	return RSSTab;
}


-(UINavigationController *)feedbackNavController
{
    if(feedbackNavController == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"feedbackNavController" owner:self options:nil];
        feedbackNavController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        feedbackNavController.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return feedbackNavController;
}


-(UIView*)landscapeOrientationView
{
    if(landscapeOrientationView == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"LandscapeHome" owner:self options:nil];
       // landscapeOrientationView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //landscapeOrientationView.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return landscapeOrientationView;
}


#pragma mark-
#pragma action Methods


-(void)loadDataArrays
{
    
    NSMutableArray* indCompDefaultArray = [[NSMutableArray alloc] initWithObjects:@"Aerco",@"Ajax Boiler",@"American Standard",@"AO Smith",@"Bradford White",@"Bryan Boilers",@"Buderus",@"Camus",@"Cemline",@"Cleaver Brooks",@"DeDietrich",@"Emerson",@"Fulton",@"Honeywell",@"HTP",@"Hurst Boiler",@"Hydrotherm",@"Johnson Controls",@"Laars",@"Lochinvar",@"Mestek, Inc",@"Noritz",@"Parker Boiler",@"Peerless Boiler",@"PVI",@"Raypak",@"RBI",@"Rheem",@"Rinnai",@"Ruud",@"Sellers Engineering",@"Thermal Solutions",@"Viessman",@"Weil McClain",@"York", nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:indCompDefaultArray forKey:@"INDDEFAULTCOMP"];
    
    [indCompDefaultArray release];
    
     NSMutableArray* indPKDefaultArray = [[NSMutableArray alloc] initWithObjects:@"Smith Energy Inc ",@"Bornquist Inc.",@"Engineered Products Company",@"Heat & Power Products Company",@"California Hydronics Corporation",@"Chesapeake Systems LLC",@"BJ Muirhead Co",nil];
    
     [[NSUserDefaults standardUserDefaults] setObject:indPKDefaultArray forKey:@"INDPKDEFAULTCUST"];
    
    [indPKDefaultArray release];
    
    
     NSMutableArray* defaultArray = [[NSMutableArray alloc] initWithObjects:@"Structural Steel Corporation ",@"O’Neal Steel Corporation",@"Triple S Steel Supply Company",@"Civies Steel Corporation",@"Pemex",@"Unicor Federal Prison Industries",@"DFW Grating Inc",@"Qualico Steel Company Inc",@"Russel Metals Inc",@"McNichols Company",nil];  
    
    [[NSUserDefaults standardUserDefaults] setObject:defaultArray forKey:@"INDIKGDEFAULTCUST"];
    
    [defaultArray release];
    
    
     NSMutableArray* airxDefaultArray = [[NSMutableArray alloc] initWithObjects:@"Authentix",@"Schlumberger",@"Texas Instruments",nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:airxDefaultArray forKey:@"INDAIRXDEFAULTCOMP"];

    [airxDefaultArray release];
    
     NSMutableArray* ikgdefaultArray = [[NSMutableArray alloc] initWithObjects:@"Fisher & Ludlow",@"AMICO",@"Ohio Gratings",nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:ikgdefaultArray forKey:@"INDIKGDEFAULTCOMP"];
    
    [ikgdefaultArray release];

    
    
    NSMutableArray* indCustDefaultArray = [[NSMutableArray alloc] initWithObjects:@"Exterran",@"Structural Steel",@"Chesapeake Systems",nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:indCustDefaultArray forKey:@"INDDEFAULTCUST"];
    
    [indCustDefaultArray release];
    
    NSMutableArray* railCompDefaultArray = [[NSMutableArray alloc] initWithObjects:@"Plasser&Theurer",@"Loram",@"Speno",@"Nordco",@"Geismar",@"Matisa",nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:railCompDefaultArray forKey:@"RAILDEFAULTCOMP"];
    
    [railCompDefaultArray release];
    
    NSMutableArray* railCustDefaultArray = [[NSMutableArray alloc] initWithObjects:@"Norfolk Southern",@"China Ministry Of Rail",@"BNSF",@"Canadian Pacific Railway",@"Canadian National Railway",@"CSX",@"Union Pacific",@"RELAM",@"Financial Corporation of Michigan",nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:railCustDefaultArray forKey:@"RAILDEFAULTCUST"];
    
    [railCustDefaultArray release];
    
    
    NSMutableArray* infraCompDefaultArray = [[NSMutableArray alloc] initWithObjects:@"BIS",@"Hertel",@"Safway",@"Doka",@"Efco",@"Lavendon",@"PERI",@"RMD",@"ULMA",@"Layher",@"Cape IS", nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:infraCompDefaultArray forKey:@"INFRADEFAULTCOMP"];
    
    [infraCompDefaultArray release];
    
    
    NSMutableArray* infraCustDefaultArray = [[NSMutableArray alloc] initWithObjects:@"Shell",@"Tata Steel",@"Total UK Ltd.",@"Sabic Petrochemcials",@"First Energy Corporation",@"The Shaw Group",@"Genon Energy Services LLC",@"Enerfab",nil];    
    [[NSUserDefaults standardUserDefaults] setObject:infraCustDefaultArray forKey:@"INFRADEFAULTCUST"];
    
    [infraCustDefaultArray release];
    
    
    
    NSMutableArray* metalsCompDefaultArray = [[NSMutableArray alloc] initWithObjects:@"TubeCity",@"Phoenix",@"AbrasivesInc",@"Dupont/Starblast",@"Ervin Industries",@"GMA Garnet (USA) Corporation",@"Green Diamond Sand Product",@"Mobile Abrasives",@"Newageblastmedia",@"Opta Minerals, Inc. ",@"U.S. Minerals",@"W Abrasives/ Pan Abrasives", nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:metalsCompDefaultArray forKey:@"METALSDEFAULTCOMP"];
    
    [metalsCompDefaultArray release];
    
    NSMutableArray* metalsCustDefaultArray = [[NSMutableArray alloc] initWithObjects:@"ESI",@"ANIE",@"ArcelorMittal",@"Outokumpu",@"IspatIndustries",@"Lucchini",nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:metalsCustDefaultArray forKey:@"METALSDEFAULTCUST"];
    
    [metalsCustDefaultArray release];
    
    
    
    
}

-(void)updateRSSFeed
{
    if(newsCount<[newsArticles count])
    {
       self.stockLabel1.text = [[newsArticles objectAtIndex:newsCount] objectForKey:@"title"];
         self.stockLabel2.text = [[newsArticles objectAtIndex:newsCount] objectForKey:@"title"];
        newsCount++;
    }
    else 
    {
        newsCount = 0;
    }
}


-(void)fetchRSSFeed
{
    RSSParser* parser = [[RSSParser alloc] init];
    parser.delegate = self;
    
  
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"RSSFEED"] length])
    {
        
        [self showHUD:@"Fetching News Articles"];
        
        NSLog(@"url is %@",[NSString stringWithFormat:@"%@%@%@",@"http://news.google.com/news?um=1&ned=us&hl=en&q=",[[NSUserDefaults standardUserDefaults] valueForKey:@"RSSFEED"],@"output=rss"]);
        [parser fetchRssFeedFromURL:[NSString stringWithFormat:@"%@%@%@",@"http://news.google.com/news?um=1&ned=us&hl=en&q=",[[NSUserDefaults standardUserDefaults] valueForKey:@"RSSFEED"],@"&output=rss"]];
    }
    else 
    {
        [self showHUD:@"Fetching News Articles"];
        [parser fetchRssFeedFromURL:@"http://news.google.com/news?um=1&ned=us&hl=en&q=harsco&output=rss"];
    }
    newsCount = 0;
    

}

-(void)displayStockQuote
{
    NSError* error = [[NSError alloc] init];
    
    NSLog(@"%@", [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://download.finance.yahoo.com/d/quotes.csv?s=HSC&f=sl1d1t1c1ohgv&e=.csv"] encoding:NSStringEncodingConversionAllowLossy error:&error]);
    
    NSString* test = [[NSString alloc] init];
    
    test =  [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://download.finance.yahoo.com/d/quotes.csv?s=HSC&f=sl1d1t1c1ohgv&e=.csv"] encoding:NSStringEncodingConversionAllowLossy error:&error];
    
    NSLog(@"string is %@", [test stringBetweenString:@"," andString:@","]); 
    
    if(![error code])
    {
    
        self.stockLabel1.text = [@"HSC   $" stringByAppendingString:[test stringBetweenString:@"," andString:@","]];
//        self.stockLabel1.textColor = [UIColor colorWithRed:0.20 green:0.70 blue:1.0 alpha:1.0];
//      //  self.stockLabel.glowColor = self.stockLabel.textColor;
//        
//        [self.stockLabel1 setGlowColor:[UIColor blackColor]];
//        
//        self.stockLabel1.glowOffset = CGSizeMake(0.0, 0.0);
//        self.stockLabel1.glowAmount = 30.0;
        
        self.stockLabel1.text = @"I've tried this code to a point and it works until my view reaches a point where it sets a different animation." ;
        
    }
    else
    {
        [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:@"Unable to get Stock Quote"];
    }
}



-(IBAction)railButtonClicked:(id)sender
{
    //railDivisionViewController* railDivisionScreen = [[railDivisionViewController alloc] init];
    self.railTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:self.railTab animated:YES];
   // [self presentModalViewController:railDivisionScreen animated:YES];
   // [railDivisionScreen release];
}

-(IBAction)metalsButtonClicked:(id)sender
{
    self.metalsTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //self.metalsTab.
    [self presentModalViewController:self.metalsTab animated:YES];
}

-(IBAction)industrialButtonClicked:(id)sender
{
    //[App_GeneralUtilities showAlertOKWithTitle:@"Harsco Industrial" withMessage:@"ComingSoon!!"];
    
 //   self.industrialTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //[self presentModalViewController:self.industrialTab animated:YES];
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please choose the appropriate business unit" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"IKG Industries",@"Air-X Changers",@"Patterson-Kelley", nil];
    
    [alert show];
    [alert release];
    
}

-(IBAction)infraButtonClicked:(id)sender
{
    //[App_GeneralUtilities showAlertOKWithTitle:@"Harsco Infrastructure" withMessage:@"ComingSoon!!"];
    self.infrastructureTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:self.infrastructureTab animated:YES];
}

-(IBAction)onsafetyButtonClicked:(id)sender
{
    //[App_GeneralUtilities showAlertOKWithTitle:@"Safety Alerts" withMessage:@"ComingSoon!!"];
//    dummyLoginView* dummy = [[dummyLoginView alloc] initWithTitle:@"Sign In- Safety Alerts" message:nil delegate:self cancelButtonTitle:@"Sign In" otherButtonTitles:@"Cancel", nil];
//    
//    [dummy show];
//    safety = YES;
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Coming Soon!!" message:@"Safety Alerts Coming Soon" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    
    [alert show];
    [alert release];
    

}
-(IBAction)onafiButtonClicked:(id)sender
{
    //[App_GeneralUtilities showAlertOKWithTitle:@"AFI" withMessage:@"ComingSoon!!"];
    
    dummyLoginView* dummy = [[dummyLoginView alloc] initWithTitle:@"Sign In- AFI" message:nil delegate:self cancelButtonTitle:@"Sign In" otherButtonTitles:@"Cancel", nil];
    
    [dummy show];
}
-(IBAction)onblogButtonClicked:(id)sender
{
    [App_GeneralUtilities showAlertOKWithTitle:@"Harsco Blog" withMessage:@"ComingSoon!!"];
}


-(IBAction)onSettingsClicked:(id)sender
{
    SettingsVC* settingsViewController = [[SettingsVC alloc] init];
    
    [self presentModalViewController:settingsViewController animated:YES];
    
    [settingsViewController release];
}

-(IBAction)onFeedBackClicked:(id)sender
{
//   // [App_GeneralUtilities showAlertOKWithTitle:@"Feedback" withMessage:@"ComingSoon!!"];
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
//   // NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"vcf"];
//   // NSData *vcfData = [NSData dataWithContentsOfFile:vcfPath];
//    
//    /*NSDictionary *vcfPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"test.vcf\"",kSKPSMTPPartContentTypeKey,
//                             @"attachment;\r\n\tfilename=\"test.vcf\"",kSKPSMTPPartContentDispositionKey,[vcfData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];*/
//    
//    testMsg.parts = [NSArray arrayWithObjects:plainPart,nil];
//    
//    //[testMsg send];
//    
//    
//    
//    [self presentModalViewController:self.feedbackNavController animated:YES];
    
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    
   // [mailController setSubject:@"Feedback"];
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
            self.industrialTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentModalViewController:self.industrialTab animated:YES];
            break;
        case 2:
            self.industrialAirXTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentModalViewController:self.industrialAirXTab animated:YES];
            break;

        case 3:
            self.industrialPKTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self presentModalViewController:self.industrialPKTab animated:YES];
            break;

        default:
            break;
    }
}

- (void)messageSent:(SKPSMTPMessage *)message
{
    [message release];
    
    NSLog(@"delegate - message sent");
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    //[message release];
     NSLog(@"error in sending - message sent");
    
    //NSLog(@"delegate - error(%d): %@", [error code], [error localizedDescription]);
}
-(IBAction)onHelpClicked:(id)sender
{
     //[App_GeneralUtilities showAlertOKWithTitle:@"Help" withMessage:@"ComingSoon!!"];
    helpViewController* helpVC = [[helpViewController alloc] init];
    helpVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
   [self presentModalViewController:helpVC animated:YES];
    
   
}

-(IBAction)onNewsButtonClicked:(id)sender
{
    NSLog(@"yes");
   // newsDetailsViewController* newsVC = [[newsDetailsViewController alloc]  initWithDataArray:newsArticles];
    
  //  [self presentModalViewController:newsVC animated:YES];
    
     self.RSSTab.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentModalViewController:self.RSSTab animated:YES];
    
   // [newsVC release];
}

#pragma mark -
#pragma mark UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: //Sign In
        {
            //self.ssoUserName = ssologinview.useridtext.text;
            //self.ssoPassword = ssologinview.passwordtext.text;
            //self.rememberLoginInfo = ssologinview.rememberSwitch.on;
            
            if(safety)
            {
                 [App_GeneralUtilities showAlertOKWithTitle:@"Safety Alerts" withMessage:@"Coming Soon"];
                safety = NO;
            }
            else
            {
                //[App_GeneralUtilities showAlertOKWithTitle:@"AFI" withMessage:@"Coming Soon"];
            }
            
            
        }
            break;
        case 1: //Cancel
           
            
            break;
        default:
            break;
    }
}


-(void)changeRSS
{
    NSLog(@"change");
    RSSParser* parser = [[RSSParser alloc] init];
    parser.delegate = self;
    
    [parser fetchRssFeedFromURL:@"http://news.google.com/news?um=1&ned=us&hl=en&q=verizon&output=rss"];
    
    newsCount = 0;
}

#pragma mark - RSS Parser Delegate
-(void)feedFetchingDidFinish:(NSMutableArray *)stories
{
    //NSLog(@"stories count is %d",[stories count]);
    
    [self dismissHUD];
    
    //NSLog(@"%@",[stories objectAtIndex:3]);
    
    newsArticles = [stories retain];
    
    [self updateRSSFeed];
    
}

-(void)feedFetchingDidFail
{
    [self dismissHUD];
    [App_GeneralUtilities showAlertOKWithTitle:@"Error!!" withMessage:@"Unable to fetch News Items"];
}


#pragma HUD methods
#pragma mark -
#pragma mark HUD Methods 
- (void)showHUD:(NSString *)message {
    if(!hudAnimatedView){
        hudAnimatedView = [VZAnimatedView animatedViewWithSuperView:self.view
                                                          labelText:message
                                                          dimScreen:NO];
    }
}

- (void)dismissHUD{
    if (hudAnimatedView) {
        [hudAnimatedView dismissView];
        hudAnimatedView = nil;
    } 
}



@end
