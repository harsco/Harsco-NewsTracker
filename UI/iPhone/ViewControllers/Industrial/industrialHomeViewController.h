//
//  industrialHomeViewController.h
//  Germanium
//
//  Created by SadikAli on 1/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App_GeneralUtilities.h"

@interface industrialHomeViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UINavigationBar* industrialHeader;
    IBOutlet UIWebView* industrialWebView;
    IBOutlet UIActivityIndicatorView* webActivityIndicator;

}

@property(nonatomic,retain)UINavigationBar* industrialHeader;
@property(nonatomic,retain)UIWebView* industrialWebView;
@property(nonatomic,retain)UIActivityIndicatorView* webActivityIndicator;
-(void)onHomeClick:(id)sender;

@end
