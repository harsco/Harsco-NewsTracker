//
//  DataDownloadOperation.h
//  Germanium
//
//  Created by SadikAli on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol dataDownloadOperationDelegate;



@interface DataDownloadOperation : NSOperation<NSURLConnectionDelegate>
{
    BOOL executing_;
    BOOL finished_;
    
    // The actual NSURLConnection management
    NSURL*    connectionURL;
    NSURLConnection*  connection;
    NSMutableData*    receivedData;
    
    id <dataDownloadOperationDelegate> delegate;
}

@property(nonatomic,retain)id<dataDownloadOperationDelegate>delegate;
- (id)initWithURL:(NSURL*)url;

@end


@protocol dataDownloadOperationDelegate <NSObject>

-(void)didDownloadData:(NSData*)downloadedData;
-(void)didFailDownloadData:(NSString*)error;

@end