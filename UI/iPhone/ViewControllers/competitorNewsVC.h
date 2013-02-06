//
//  competitorNewsVC.h
//  Germanium
//
//  Created by SadikAli on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSParser.h"
#import "App_GeneralUtilities.h"
#import "newsWebVC.h"
#import "VZAnimatedView.h"

@interface competitorNewsVC : UIViewController<UITableViewDataSource,UITableViewDelegate,rssparserdelegate>
{
    IBOutlet UITableView* newsTable;
    IBOutlet UINavigationBar* newsHeader;
    
    IBOutlet UIActivityIndicatorView* spinningIndicator;
    
    NSMutableArray* dataArray;
    
    NSString* rssFeedTopic;
    
    VZAnimatedView *hudAnimatedView;
}

@property(nonatomic,retain)IBOutlet UITableView* newsTable;
@property(nonatomic,retain)UINavigationBar* newsHeader;
@property(nonatomic,retain)NSString* rssFeedTopic;
@property(nonatomic,retain)UIActivityIndicatorView* spinningIndicator;

-(void)fetchRSSFeed;
- (void)showHUD:(NSString *)message;
- (void)dismissHUD;


@end
