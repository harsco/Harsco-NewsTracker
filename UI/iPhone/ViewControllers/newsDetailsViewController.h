//
//  newsDetailsViewController.h
//  Germanium
//
//  Created by SadikAli on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Default_TableCell.h"
#import "industrialProductsWebVC.h"
#import "newsWebVC.h"
#import "RSSParser.h"

@interface newsDetailsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,rssparserdelegate>
{
    IBOutlet UITableView* newsTable;
     IBOutlet UINavigationBar* newsHeader;
    
    IBOutlet UIActivityIndicatorView* loadingIndicator;
    
    
    NSMutableArray* dataArray;
}

@property(nonatomic,retain)IBOutlet UITableView* newsTable;
@property(nonatomic,retain)UINavigationBar* newsHeader;
@property(nonatomic,retain)UIActivityIndicatorView* loadingIndicator;


-(id)initWithDataArray:(NSMutableArray*)dataSource;

@end
