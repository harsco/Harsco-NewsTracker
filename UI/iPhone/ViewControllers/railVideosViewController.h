//
//  railVideosViewController.h
//  Germanium
//
//  Created by SadikAli on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App_GeneralUtilities.h"

@interface railVideosViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView* railVideosWebView;
    IBOutlet UINavigationBar* railHeader;
    IBOutlet UIActivityIndicatorView* webActivityIndicator;
}

@property(nonatomic,retain)UIWebView* railVideosWebView;
@property(nonatomic,retain)UINavigationBar* railHeader;
@property(nonatomic,retain)UIActivityIndicatorView* webActivityIndicator;
-(void)onHomeClick:(id)sender;



@end
