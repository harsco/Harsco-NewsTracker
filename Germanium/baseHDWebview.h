//
//  baseHDWebview.h
//  Germanium
//
//  Created by SadikAli on 9/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App_GeneralUtilities.h"

@interface baseHDWebview : UIViewController<UIWebViewDelegate>
{
    
    IBOutlet UINavigationBar* railHeader;
    IBOutlet UIWebView* railWebView;
    IBOutlet UIActivityIndicatorView* webActivityIndicator;
}

@property(nonatomic,retain)UINavigationBar* railHeader;
@property(nonatomic,retain)UIWebView* railWebView;
@property(nonatomic,retain)UIActivityIndicatorView* webActivityIndicator;

-(void)onHomeClick:(id)sender;
-(void)loadRequest;

@end
