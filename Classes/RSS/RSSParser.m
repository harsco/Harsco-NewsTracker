//
//  RSSParser.m
//  Germanium
//
//  Created by SadikAli on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RSSParser.h"

@implementation RSSParser

@synthesize delegate;

-(id)init
{
    if(self = [super init])
    {
        
    }
    
    return self;
}



-(void)fetchRssFeedFromURL:(NSString*)path
{
    NSLog(@"path is %@",path);
    
    NSOperationQueue* testQueue = [[NSOperationQueue alloc] init];
    [testQueue setMaxConcurrentOperationCount:1];
    
    DataDownloadOperation* loginOp = [[DataDownloadOperation alloc] initWithURL:[NSURL URLWithString:path]];
    loginOp.delegate = self;
    //loginOp.delegate = self;
    
    [testQueue addOperation:loginOp];
    
    //[self parseXMLFileAtURL:path];
}



- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	NSLog(@"found file and started parsing");
	
}

-(void)parseXMLFileWithData:(NSData*)data
{
    stories = [[NSMutableArray alloc] init];
    
    rssParser = [[NSXMLParser alloc] initWithData:data];
    
    [rssParser setDelegate:self];
    
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];
	
    [rssParser parse];
}

- (void)parseXMLFileAtURL:(NSString *)URL
{	
	stories = [[NSMutableArray alloc] init];
	
    //you must then convert the path to a proper NSURL or it won't work
    NSURL *xmlURL = [NSURL URLWithString:URL];
	
    // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
    // this may be necessary only for the toolchain
    rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [rssParser setDelegate:self];
	
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];
	
    [rssParser parse];
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{			
    //NSLog(@"found this element: %@", elementName);
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"item"]) {
		// clear out our story item caches...
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
		currentSummary = [[NSMutableString alloc] init];
		currentLink = [[NSMutableString alloc] init];
	}
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	//NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"item"]) {
		// save values to an item, then store that item into the array...
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentLink forKey:@"link"];
		[item setObject:currentSummary forKey:@"summary"];
		[item setObject:currentDate forKey:@"date"];
		
		[stories addObject:[item copy]];
		NSLog(@"adding story: %@", currentTitle);
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	//NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	} else if ([currentElement isEqualToString:@"link"]) {
		[currentLink appendString:string];
	} else if ([currentElement isEqualToString:@"description"]) {
		[currentSummary appendString:string];
	} else if ([currentElement isEqualToString:@"pubDate"]) {
		[currentDate appendString:string];
	}
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	
	//[activityIndicator stopAnimating];
	//[activityIndicator removeFromSuperview];
	
	NSLog(@"all done!");
	NSLog(@"stories array has %d items", [stories count]);
    
    [delegate feedFetchingDidFinish:stories];
    
	//[newsTable reloadData];
}

#pragma data download
-(void)didDownloadData:(NSData *)downloadedData
{
    receivedData = [[NSMutableData alloc] initWithData:downloadedData];
    
    NSLog(@"data is %s",[receivedData bytes]);
    
    [self parseXMLFileWithData:receivedData];
}

-(void)didFailDownloadData:(NSString *)error
{
    //show error
    NSLog(@"error occured downloading");
    
   
	
//	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:@"Unable to get News items" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//	[errorAlert show];
    
    [delegate feedFetchingDidFail];
    
    
}

@end
