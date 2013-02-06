//
//  App_HDHomeScreenViewController.h
//  Germanium
//
//  Created by SadikAli on 9/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App_HomeScreen.h"
#import "settingsHDVC.h"
#import "helpHDVC.h"
#import <MessageUI/MessageUI.h>

@interface App_HDHomeScreenViewController : App_HomeScreen<MFMailComposeViewControllerDelegate>
{
     IBOutlet UITabBarController* railHDTab;
    IBOutlet UITabBarController* metalsHDTab;
    IBOutlet UITabBarController* infrastructureHDTab;
    IBOutlet UITabBarController* indHDIKGTab;
    IBOutlet UITabBarController* indHDPKTab;
    IBOutlet UITabBarController* indHDAXCTab;
    
    IBOutlet UINavigationController* feedbackHDNavVC;
    
    IBOutlet UIView* landscapeView;
    
    
}

@property(nonatomic,retain)UITabBarController* railHDTab;
@property(nonatomic,retain)UITabBarController* metalsHDTab;
@property(nonatomic,retain)UITabBarController* infrastructureHDTab;
@property(nonatomic,retain)UITabBarController* indHDIKGTab;
@property(nonatomic,retain)UITabBarController* indHDPKTab;
@property(nonatomic,retain)UITabBarController* indHDAXCTab;
@property(nonatomic,retain)UINavigationController* feedbackHDNavVC;
@property(nonatomic,retain)UIView* landscapeView;

@end
