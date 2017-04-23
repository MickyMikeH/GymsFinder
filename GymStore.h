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

@property (nonatomic, copy) NSArray *gymItems;

@property (nonatomic, copy) NSURL *nextLink;

@end

@interface GymItems : MTLModel<MTLJSONSerializing>

/*
 "GymID": 6576,
 "Name": "頂溪國小運動場",
 "OperationTel": "(02)29212058",
 "Address": "新北市永和區文化路133號",
 "Rate": 0,
 "RateCount": 0,
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
