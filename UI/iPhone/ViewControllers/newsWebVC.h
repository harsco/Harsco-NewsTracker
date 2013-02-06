//
//  newsWebVC.h
//  Germanium
//
//  Created by SadikAli on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App_GeneralUtilities.h"

@interface newsWebVC : UIViewController<UIWebViewDelegate>
{
    IBOutlet UINavigationBar* newsHeader;
    IBOutlet UIWebView* webView;
    IBOutlet UIActivityIndicatorView* webActivityIndicator;
    
    NSString* url;
}

@property(nonatomic,retain)UINavigationBar* newsHeader;
@property(nonatomic,retain)UIWebView* webView;
@property(nonatomic,retain)NSString* url;
@property(nonatomic,retain)UIActivityIndicatorView* webActivityIndicator;


-(id)initWithURLString:(NSString*)urlstring;


@end
