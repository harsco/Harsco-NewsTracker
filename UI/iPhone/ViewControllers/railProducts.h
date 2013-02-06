//
//  railProducts.h
//  Germanium
//
//  Created by SadikAli on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App_GeneralUtilities.h"
@interface railProducts : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView* railWebView;
    IBOutlet UINavigationBar* railHeader;
    IBOutlet UIActivityIndicatorView* webActivityIndicator;
}

@property(nonatomic,retain)UIWebView* railWebView;
@property(nonatomic,retain)UINavigationBar* railHeader;
@property(nonatomic,retain)UIActivityIndicatorView* webActivityIndicator;
-(void)onHomeClick:(id)sender;

@end
