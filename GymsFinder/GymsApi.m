//
//  GymsApi.m
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/15.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import "GymsApi.h"

static NSString * const GYM_SEARCH_ALL = @"https://iplay.sa.gov.tw/api/GymSearchAllList?$format=application/json";
static NSString * const GymList = @"GymList";

@implementation GymsApi

//+ (void)startDownLoad:(CompletionHandler)completionHandler {
//    __block NSError *downLoadError = nil;
//    __block NSUInteger count = 0;
//    [GymsApi downloadAllCityAndCountry:^(NSError *error) {
//        downLoadError = error;
//        count ++;
//        if (count == 2) {
//            completionHandler (downLoadError);
//        }
//    }];
//    [GymsApi downloadGymAllList:^(NSError *error) {
//        downLoadError = error;
//        count ++;
//        if (count == 2) {
//            completionHandler (downLoadError);
//        }
//    }];
//}

+ (void)downloadGymAllList:(CompletionHandler)completionHandler {
    [self downloadFileWithFileName:GymList URLstring:GYM_SEARCH_ALL completionHandler:^(NSError *error) {
        completionHandler (error);
    }];
}


@end
