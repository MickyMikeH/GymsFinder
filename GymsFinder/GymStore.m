//
//  GymStore.m
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/17.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import "GymStore.h"
#import "FileManager.h"

@implementation GymStore

+ (instancetype)sharedInstance {
    static GymStore *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GymStore alloc] init];
        [instance parseJSONArray:[FileManager parseJSONArrayWithFileName:@"CityList.json"]];
    });
    return instance;
}

- (void)parseJSONArray:(NSArray *)array {
    self.items = [NSArray arrayWithArray:[MTLJSONAdapter modelsOfClass:[CityItems class] fromJSONArray:array error:nil]];
}

@end
@implementation CityItems
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"cityID" : @"id",
             @"cityName" : @"name",
             @"countrys" : @"towns"
             };
}

+ (NSValueTransformer *)countrysJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[CountryItems class]];
}


@end

@implementation CountryItems

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"countryID" : @"id",
             @"countryName" : @"name",
             @"countryPostal" : @"postal"
             };
}

@end
