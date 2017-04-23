//
//  BaseApi.h
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/22.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSTimeInterval const TIME_OUT;

typedef void(^CompletionHandler)(NSError *error);

@interface BaseApi : NSObject

+ (void)downloadFileWithFileName:(NSString *)fileName URLstring:(NSString *)URLstring isPost:(BOOL)isPost completionHandler:(CompletionHandler)completionHandler;

@end
