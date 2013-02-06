//
//  newsItemsVC.h
//  Germanium
//
//  Created by SadikAli on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSParser.h"
#import "App_GeneralUtilities.h"
#import "newsWebVC.h"


@interface newsItemsVC : UIViewController<UITableViewDataSource,UITableViewDelegate,rssparserdelegate>
{
    IBOutlet UITableView* newsTable;
    IBOutlet UINavigationBar* newsHeader;
    
    IBOutlet UIActivityIndicatorView* loadingIndicator;
    
    NSMutableArray* dataArray;
    
    NSString* rssFeedTopic;
}


@property(nonatomic,retain)IBOutlet UITableView* newsTable;
@property(nonatomic,retain)UINavigationBar* newsHeader;
@property(nonatomic,retain)NSString* rssFeedTopic;
@property(nonatomic,retain)UIActivityIndicatorView* loadingIndicator;


-(void)fetchRSSFeed;



@end
