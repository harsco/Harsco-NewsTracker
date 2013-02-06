//
//  HSCAppDelegate.h
//  Germanium
//
//  Created by SadikAli on 12/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class App_HomeScreen;
#import "Reachability.h"
#import "App_GeneralUtilities.h"
#import "App_HDHomeScreenViewController.h"

@interface HSCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) App_HomeScreen *viewController;
@property(strong,nonatomic) App_HDHomeScreenViewController *hdViewController;

@end
