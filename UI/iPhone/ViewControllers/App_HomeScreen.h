//
//  App_HomeScreen.h
//  Germanium
//
//  Created by SadikAli on 12/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App_GeneralUtilities.h"
#import "railDivisionViewController.h"
#import "NSString+NSString_Helper.h"
#import "RRSGlowLabel.h"

#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"
#import <CFNetwork/CFNetwork.h>

#import <QuartzCore/CoreAnimation.h>

#import "helpViewController.h"

#import "dummyLoginView.h"
#import "newsDetailsViewController.h"
#import "RSSParser.h"
#import "SettingsVC.h"

#import "VZAnimatedView.h"
#import <MessageUI/MessageUI.h>



@interface App_HomeScreen : UIViewController<SKPSMTPMessageDelegate,UIAlertViewDelegate,rssparserdelegate,MFMailComposeViewControllerDelegate>
{
    UIImageView* homeScreenBackground;
    
   IBOutlet UITabBarController* railTab;
   IBOutlet UITabBarController* metalsTab;
   IBOutlet UITabBarController* industrialTab;
   IBOutlet UITabBarController* infrastructureTab;
   IBOutlet UITabBarController* industrialAirXTab;
   IBOutlet UITabBarController* industrialPKTab;
    
   IBOutlet UITabBarController* RSSTab;
    
   IBOutlet UINavigationController* feedbackNavController;
    
    
    
    
   IBOutlet UIButton* railButton;
   IBOutlet UIButton* metalsButton;
   IBOutlet UIButton* industrialButton;
   IBOutlet UIButton* infrastructureButton;
    

    
    IBOutlet UIButton* safetyButton;
    IBOutlet UIButton* afiButton;
    IBOutlet UIButton* blogButton;
    
    IBOutlet UIButton* newsButton;
    
   //misc buttons can be anything 
    
   IBOutlet UIButton* feedbackButton;
   IBOutlet UIButton* helpButton;
   IBOutlet UIButton* settingsButton;
    
   IBOutlet UILabel* stockLabel1;
    IBOutlet UILabel* stockLabel2;
    
   NSTimer* stockTimer;
    NSTimer* rssupdateTimer;
   BOOL safety;
    
   NSInteger newsCount;
   NSMutableArray* newsArticles;
    
   VZAnimatedView *hudAnimatedView;
    
    IBOutlet UIView* landscapeOrientationView;
    
    BOOL isShowingLandscapeView;
    
}

@property(nonatomic,retain)UITabBarController* railTab;
@property(nonatomic,retain)UITabBarController* metalsTab;
@property(nonatomic,retain)UITabBarController* industrialTab;
@property(nonatomic,retain)UITabBarController* infrastructureTab;
@property(nonatomic,retain)UITabBarController* industrialAirXTab;
@property(nonatomic,retain)UITabBarController* industrialPKTab;
@property(nonatomic,retain)UITabBarController* RSSTab;

@property(nonatomic,retain)UINavigationController* feedbackNavController;

@property(nonatomic,retain)UIImageView* homeScreenBackground;
@property(nonatomic,retain)UIButton* railButton;
@property(nonatomic,retain)UIButton* metalsButton;
@property(nonatomic,retain)UIButton* industrialButton;
@property(nonatomic,retain)UIButton* infrastructureButton;
@property(nonatomic,retain)UIButton* safetyButton;
@property(nonatomic,retain)UIButton* afiButton;
@property(nonatomic,retain)UIButton* blogButton;
@property(nonatomic,retain)UIButton* newsButton;
//misc buttons can be anything
@property(nonatomic,retain)UIButton* feedbackButton;
@property(nonatomic,retain)UIButton* helpButton;
@property(nonatomic,retain)UIButton* settingsButton;

@property(nonatomic,retain)UILabel* stockLabel1;
@property(nonatomic,retain)UILabel* stockLabel2;

@property(nonatomic,retain)NSTimer* stockTimer;
@property(nonatomic,retain)NSTimer* rssupdateTimer;
@property(nonatomic,retain)UIView* landscapeOrientationView;


-(void)displayStockQuote;

-(void)reloadAnimation;

-(IBAction)railButtonClicked:(id)sender;
-(IBAction)metalsButtonClicked:(id)sender;
-(IBAction)industrialButtonClicked:(id)sender;
-(IBAction)infraButtonClicked:(id)sender;
-(IBAction)onsafetyButtonClicked:(id)sender;
-(IBAction)onafiButtonClicked:(id)sender;
-(IBAction)onblogButtonClicked:(id)sender;

-(IBAction)onFeedBackClicked:(id)sender;
-(IBAction)onHelpClicked:(id)sender;

-(IBAction)onNewsButtonClicked:(id)sender;

-(IBAction)onSettingsClicked:(id)sender;

-(void)loadDataArrays;

- (void)showHUD:(NSString *)message;
- (void)dismissHUD;

@end
