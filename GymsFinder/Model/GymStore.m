//
//  GymStore.m
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/23.
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
    });
    return instance;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

//+ (NSValueTransformer *)gymItemsJSONTransformer {
//    return [MTLJSONAdapter arrayTransformerWithModelClass:[GymItems class]];
//}

//+ (NSValueTransformer *)nextLinkJSONTransformer {
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//}

- (void)parseJSONArrayWithCity:(NSString *)city country:(NSString *)country {
    NSString *txtPath = [FileManager documentPathWithFileName:[NSString stringWithFormat:@"GymList_%@_%@.json",city ,country]];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:txtPath] options: NSJSONReadingMutableContainers error:nil];
    
//    return [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:dic error:nil];
    
    self.gymItems = [NSArray arrayWithArray:[MTLJSONAdapter modelsOfClass:[GymItems class] fromJSONArray:array error:nil]];
}

@end

@implementation GymItems
/*

 GymID：場館編號
 Name：場館名稱
 OperationTel：連絡電話
 Address：場館地址
 Rate：平均評分
 RateCount：評份個數
 Distance：目前距離
 GymFuncList：設施清單
 Photo1：場館照片
 LatLng：場館經緯度
 
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"gymID" : @"GymID",
             @"name" : @"Name",
             @"tel" : @"OperationTel",
             @"address" : @"Address",
             @"rate" : @"Rate",
             @"rateCount" : @"RateCount",
             @"distance" : @"Distance",
             @"gymFuncList" : @"GymFuncList",
             @"photo1" : @"Photo1",
             @"latLng" : @"LatLng"
             };
}

//+ (NSValueTransformer *)photo1JSONTransformer {
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//}
@end
