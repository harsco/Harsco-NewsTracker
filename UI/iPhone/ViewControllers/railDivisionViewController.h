//
//  railDivisionViewController.h
//  Germanium
//
//  Created by SadikAli on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "railProducts.h"

@interface railDivisionViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UINavigationBar* railHeader;
    IBOutlet UIWebView* railWebView;
    IBOutlet UIActivityIndicatorView* webActivityIndicator;
}


@property(nonatomic,retain)UINavigationBar* railHeader;
@property(nonatomic,retain)UIWebView* railWebView;
@property(nonatomic,retain)UIActivityIndicatorView* webActivityIndicator;


-(void)onHomeClick:(id)sender;





@end
