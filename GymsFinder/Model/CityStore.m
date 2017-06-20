//
//  CityStore.m
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/23.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import "CityStore.h"
#import "FileManager.h"

@implementation CityStore

+ (instancetype)sharedInstance {
    static CityStore *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:[FileManager dictionaryWithContenOfJSONString:@"city.json"] error:nil];
    });
    return instance;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"cityItems" : @"value"};
}

+ (NSValueTransformer *)cityItemsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CityItems class]];
}

- (void)parseCountryJSONArray:(NSArray *)array {
    self.countryItems = [NSArray arrayWithArray:[MTLJSONAdapter modelsOfClass:[CountryItems class] fromJSONArray:array error:nil]];
}

- (void)clearCountryItems {
    self.countryItems = nil;
}

@end

@implementation CityItems

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"cityName" : @"City"};
}

@end

@implementation CountryItems

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"countryName" : @"Value"};
}

@end
