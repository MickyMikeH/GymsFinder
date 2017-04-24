//
//  GymStore.m
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/17.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import "CityStore_bak.h"
#import "FileManager.h"

@implementation CityStore_bak

+ (instancetype)sharedInstance {
    static CityStore_bak *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CityStore_bak alloc] init];
        [instance parseJSONArray:[FileManager parseJSONArrayWithFileName:@"CityList.json"]];
    });
    return instance;
}

- (void)parseJSONArray:(NSArray *)array {
    self.items = [NSArray arrayWithArray:[MTLJSONAdapter modelsOfClass:[CityItems_bak class] fromJSONArray:array error:nil]];
}

@end
@implementation CityItems_bak
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"cityID" : @"id",
             @"cityName" : @"name",
             @"countrys" : @"towns"
             };
}

+ (NSValueTransformer *)countrysJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CountryItems_bak class]];
}


@end

@implementation CountryItems_bak

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"countryID" : @"id",
             @"countryName" : @"name",
             @"countryPostal" : @"postal"
             };
}

@end
