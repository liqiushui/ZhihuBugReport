//
//  BRBugReportEngine.h
//  BugReport
//
//  Created by vousaimer on 15-7-28.
//  Copyright (c) 2015年 va. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRBugReportEngine : NSObject<NSURLConnectionDelegate>

+ (instancetype)getInstance;


- (void)sendBug:(NSDictionary *)bugInfo;

@end
