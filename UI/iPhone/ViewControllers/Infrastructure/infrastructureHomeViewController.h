//
//  infrastructureHomeViewController.h
//  Germanium
//
//  Created by SadikAli on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App_GeneralUtilities.h"

@interface infrastructureHomeViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UINavigationBar* infrastructureHeader;
    IBOutlet UIWebView* infrastructureWebView;
    IBOutlet UIActivityIndicatorView* webActivityIndicator;
}

@property(nonatomic,retain)UINavigationBar* infrastructureHeader;
@property(nonatomic,retain)UIWebView* infrastructureWebView;
@property(nonatomic,retain)UIActivityIndicatorView* webActivityIndicator;
-(void)onHomeClick:(id)sender;

@end
