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
static NSString * const GYM_TYPE_LIST_BY_NAME = @"https://iplay.sa.gov.tw/GymType/GymTypeListByName?GymKindName=%@";
static NSString * const GYM_SEARCH_BY_GYM_ID = @"https://iplay.sa.gov.tw/odata/Gym(%@)?$format=application/json;odata.metadata=none&$expand=GymRateData";



static NSString * const GymList = @"GymList";
static NSString * const GymListCityCountry = @"GymList_%@_%@";
static NSString * const GymType = @"GymType_%@";

@implementation GymsApi

+ (void)downloadGymWithCity:(NSString *)city country:(NSString *)country completionHandler:(CompletionHandler)completionHandler {

    NSString *cityName = [city stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    NSString *countryName = [country stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    [self downloadFileWithFileName:[NSString stringWithFormat:GymListCityCountry, city, country] URLstring:[NSString stringWithFormat:GYM_SEARCH_NPAGE, cityName, countryName] isPost:NO completionHandler:^(NSError *error) {
        
        completionHandler (error);
    }];
}

+ (void)downloadGymTypeListWithGymKind:(NSString *)gymKind completionHandler:(CompletionHandler)completionHandler {

    NSString *gymKindName = [gymKind stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    [self downloadFileWithFileName:gymKind URLstring:[NSString stringWithFormat:GYM_TYPE_LIST_BY_NAME, gymKindName] isPost:YES completionHandler:^(NSError *error) {
        
        completionHandler (error);
    }];
}

+ (void)downloadGymWithGymID:(NSString *)gymID completionHandler:(CompletionHandler)completionHandler {
    
    [self downloadFileWithFileName:gymID URLstring:[NSString stringWithFormat:GYM_SEARCH_BY_GYM_ID, gymID] isPost:NO completionHandler:^(NSError *error) {
        
        completionHandler (error);
    }];
}
@end
