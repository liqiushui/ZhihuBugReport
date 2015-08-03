//
//  BRBugReportEngine.m
//  BugReport
//
//  Created by vousaimer on 15-7-28.
//  Copyright (c) 2015年 va. All rights reserved.
//

#import "BRBugReportEngine.h"
#import <UIKit/UIKit.h>

#define ReportUrl @"http://127.0.0.1:8080/BugReport?msg=test"

@interface BRBugReportEngine ()

@property (nonatomic, strong) NSMutableData *responseData;

@end


@implementation BRBugReportEngine

+ (instancetype)getInstance
{
    static BRBugReportEngine *engine = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        engine = [[BRBugReportEngine alloc] init];
    });
    
    return engine;
}


- (void)sendBug:(NSDictionary *)bugInfo
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:ReportUrl]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:20];
    UIImage *img = bugInfo[@"image"];

    request.HTTPMethod = @"POST";
    [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [bugInfo enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if(![key isEqual:@"image"])
        {
            [request setValue:obj forHTTPHeaderField:key];
        }
    }];
    
    request.HTTPBody = UIImageJPEGRepresentation(img, 0.5);
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Error|%s|%s|%d|Send Bug Report error,errMsg = %@", __FILE__, __FUNCTION__, __LINE__,error);
}
@end
