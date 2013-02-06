//
//  RSSParser.h
//  Germanium
//
//  Created by SadikAli on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataDownloadOperation.h"

@protocol rssparserdelegate;

@interface RSSParser : NSObject<NSXMLParserDelegate,dataDownloadOperationDelegate>
{
    NSXMLParser * rssParser;
    NSMutableArray * stories;
	
	
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString * currentElement;
	NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink;
    
    NSMutableData* receivedData;
    
    id <rssparserdelegate>delegate;

}


@property(nonatomic,retain)id<rssparserdelegate>delegate;

-(void)fetchRssFeedFromURL:(NSString*)path;
-(void)parseXMLFileWithData:(NSData*)data;



@end


@protocol rssparserdelegate <NSObject>

-(void)feedFetchingDidFinish:(NSMutableArray *)stories;
-(void)feedFetchingDidFail;

@end