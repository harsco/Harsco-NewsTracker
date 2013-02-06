//
//  metalsVideosVC.h
//  Germanium
//
//  Created by SadikAli on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "metalsInnovationDetailsViewController.h"

@interface metalsVideosVC : UIViewController<UIWebViewDelegate>
{
    IBOutlet UINavigationBar* metalHeader;
    IBOutlet UIWebView* metalsWebView;
    IBOutlet UIActivityIndicatorView* webActivityIndicator;
}

@property(nonatomic,retain)UINavigationBar* metalHeader;
@property(nonatomic,retain)UIWebView* metalsWebView;
@property(nonatomic,retain)UIActivityIndicatorView* webActivityIndicator;

@end
