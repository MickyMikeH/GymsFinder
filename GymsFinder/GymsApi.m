//
//  GymsApi.m
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/15.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import "GymsApi.h"

static NSString * const GYM_SEARCH_ALL = @"https://iplay.sa.gov.tw/api/GymSearchAllList?$format=application/json";
static NSString * const GYM_SEARCH_NPAGE = @"https://iplay.sa.gov.tw/api/GymSearchAllList?$format=application/json;odata.metadata=none&City=%@&Country=%@";
static NSString * const GymList = @"GymList";
static NSString * const GymListCityCountry = @"GymList_%@_%@";

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
+ (void)downloadGymWithCity:(NSString *)city country:(NSString *)country completionHandler:(CompletionHandler)completionHandler {

    NSString *cityName = [city stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    NSString *countryName = [country stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    [self downloadFileWithFileName:[NSString stringWithFormat:GymListCityCountry, city, country] URLstring:[NSString stringWithFormat:GYM_SEARCH_NPAGE, cityName, countryName] isPost:NO completionHandler:^(NSError *error) {
        
        completionHandler (error);
    }];
}

+ (void)downloadGymAllList:(CompletionHandler)completionHandler {
//    [self downloadFileWithFileName:GymList URLstring:GYM_SEARCH_ALL completionHandler:^(NSError *error) {
//        completionHandler (error);
//    }];
}


@end
