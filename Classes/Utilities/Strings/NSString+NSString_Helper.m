//
//  NSString+NSString_Helper.m
//  Germanium
//
//  Created by SadikAli on 12/22/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+NSString_Helper.h"

@implementation NSString (NSString_Helper)

-(NSString*)stringBetweenString:(NSString*)start andString:(NSString *)end {
    NSScanner* scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    [scanner scanUpToString:start intoString:NULL];
    if ([scanner scanString:start intoString:NULL]) {
        NSString* result = nil;
        if ([scanner scanUpToString:end intoString:&result]) {
            return result;
        }
    }
    return nil;
}

@end
