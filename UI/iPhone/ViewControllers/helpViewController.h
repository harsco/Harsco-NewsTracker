//
//  helpViewController.h
//  Germanium
//
//  Created by SadikAli on 1/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface helpViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView* helpView;
    IBOutlet UINavigationBar* helpHeader;
}

@property(nonatomic,retain)UIWebView* helpView;
@property(nonatomic,retain)UINavigationBar* helpHeader;

-(void)onHomeClick:(id)sender;
-(void)loadHelpPage;


@end
