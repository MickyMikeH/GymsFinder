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
        instance.gymKind = [[MTLJSONAdapter modelOfClass:[GymKind class] fromJSONDictionary:[FileManager dictionaryWithContenOfJSONString:@"gymKind.json"] error:nil] gymKinds];
    });
    return instance;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{};
}

- (void)parseJSONArrayWithCity:(NSString *)city country:(NSString *)country {
    NSString *txtPath = [FileManager documentPathWithFileName:[NSString stringWithFormat:@"GymList_%@_%@.json",city ,country]];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:txtPath] options: NSJSONReadingMutableContainers error:nil];
    
    self.gymItems = [NSArray arrayWithArray:[MTLJSONAdapter modelsOfClass:[GymItems class] fromJSONArray:array error:nil]];
}

- (void)parseJSONArrayWithGymType:(NSString *)gymType {
    NSString *txtPath = [FileManager documentPathWithFileName:[NSString stringWithFormat:@"%@.json", gymType]];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:txtPath] options: NSJSONReadingMutableContainers error:nil];
    
    self.gymTypes = [NSArray arrayWithArray:[MTLJSONAdapter modelsOfClass:[GymTypeItem class] fromJSONArray:array error:nil]];
}

- (void)parseJSONArrayWithGymID:(NSString *)GymID {
    NSString *txtPath = [FileManager documentPathWithFileName:[NSString stringWithFormat:@"%@.json", GymID]];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:txtPath] options: NSJSONReadingMutableContainers error:nil];
    
    self.gymDetailRateItems = [NSArray arrayWithArray:[MTLJSONAdapter modelsOfClass:[GymItems class] fromJSONArray:array error:nil]];
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
+ (Class)classForParsingJSONDictionary:(NSDictionary *)JSONDictionary {
    if (JSONDictionary[@"WebUrl"] != nil) {
        return [GymDetailRateItems class];
    }
    
    return self;
}

@end

/*
 "ID": 場館編號,
 "GymType": 設施項目,
 "Name": 場館名稱,
 "Addr": 場館地址,
 "OperationTel": 場館連絡電話,
 "WebUrl":場館官方網站,
 "ParkType": 場館停車場類型,
 "EnableYear": 場館啟用年,
 "EnableMonth": 場館啟用月,
 "Introduction": 場館簡介,
 "Contest": 曾舉辦過賽事類型,
 "ContestIntro": 曾舉辦過賽事詳細資訊,
 "Lat": 場館所在位置緯度,
 "Lng": 場館所在位置精度,
 "Photo1Url":場館照片1,
 "Photo2Url": 場館照片2,
 "PassEasyEle": 無障礙電梯數量,
 "PassEasyElePhotoUrl": 無障礙電梯照片,
 "PassEasyFuncOthers": 其他建築物無障礙設施,
 "PassEasyParking": 無障礙停車位數量,
 "PassEasyParkingPhotoUrl": 無障礙停車位照片,
 "PassEasyShower": 無障礙廁所,
 "PassEasyShowerPhotoUrl": "http://az804957.vo.msecnd.net/passeasyphotogym/臺中市（西屯區）朝馬國民運動中心無障礙淋浴間照片20161216175911.jpg",
 "PassEasyToilet": 無障礙廁所數量,
 "PassEasyToiletPhotoUrl": 無障礙廁所照片,
 "PassEasyWay": 無障礙坡道數量,
 "PassEasyWayPhotoUrl": 無障礙坡道照片,
 "WheelchairAuditorium": 輪椅觀眾席數量,
 "WheelchairAuditoriumPhotoUrl": 輪椅觀眾席照片,
 "PublicTransport": 交通資訊,
 "Declaration": 公告,
 "DeclarationUrl": 公告相關網址,
 "Rate": 平均評分,
 "RateCount": 評分數,
 "GymRateData": 評分詳細資訊[
 {
 "Rate": 評分,
 "Message": 留言
 }
 ]
 */

@implementation GymDetailRateItems

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"url" : @"WebUrl",
             @"contest" : @"Contest",
             @"publicTransport" : @"PublicTransport",
             @"declaration" : @"Declaration",
             @"declarationUrl" : @"DeclarationUrl",
             @"rate" : @"Rate",
             @"rateCount" : @"RateCount",
             @"rateData" : @"GymRateData"};
}

+ (NSValueTransformer *)rateDataJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[GymRateData class]];
}

@end

@implementation GymRateData

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"rateID" : @"RateID",
             @"message" : @"Message"};
}

@end
@implementation GymKind

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"gymKinds" : @"value"};
}

+ (NSValueTransformer *)gymKindsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[GymKindItem class]];
}
@end

@implementation GymKindItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"gymKindItem" : @"GymKind"};
}

@end

@implementation GymTypeItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name" : @"Name",
             @"code" : @"Code"
             };
}

@end
