//
//  GymStore.h
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/23.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface GymStore : MTLModel<MTLJSONSerializing>

+ (instancetype)sharedInstance;

- (void)parseJSONArrayWithCity:(NSString *)city country:(NSString *)country;

- (void)parseJSONArrayWithGymType:(NSString *)gymType;

- (void)parseJSONArrayWithGymID:(NSString *)GymID;

@property (nonatomic, copy) NSArray *gymItems;

@property (nonatomic, copy) NSArray *gymDetailRateItems;

@property (nonatomic, copy) NSURL *nextLink;

@property (nonatomic, copy) NSArray *gymKind;

@property (nonatomic, copy) NSArray *gymTypes;
@end

@interface GymItems : MTLModel<MTLJSONSerializing>

/*
 "GymID": 6576,
 "Name": "頂溪國小運動場",
 "OperationTel": "(02)29212058",
 "Address": "新北市永和區文化路133號",
 "Rate": 0,
 "RateCount": 0,x
 "Distance": 0,
 "GymFuncList": "田徑場,躲避球場",
 "Photo1": "https://az804957.vo.msecnd.net/photogym/20140613113346_P6160509.JPG",
 "LatLng": "25.0150148574931,121.511353254318"
 */

@property (nonatomic, copy) NSNumber *gymID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSNumber *rate;
@property (nonatomic, copy) NSNumber *rateCount;
@property (nonatomic, copy) NSNumber *distance;
@property (nonatomic, copy) NSString *gymFuncList;
@property (nonatomic, copy) NSString *photo1;
@property (nonatomic, copy) NSString *latLng;

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
@interface GymDetailRateItems : GymItems

@end

@interface GymRateData : GymDetailRateItems

@property (nonatomic, copy) NSNumber *rateID;
//@property (nonatomic, copy) NSNumber *rate;
@property (nonatomic, copy) NSString *message;

@end

@interface GymKind : MTLModel<MTLJSONSerializing>
@property (nonatomic, copy) NSArray *gymKinds;
@end

@interface GymKindItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *gymKindItem;

@end

@interface GymTypeItem : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;

@end
