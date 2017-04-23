//
//  GymStore.h
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/17.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface GymStore : MTLModel

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSArray *items;
@end

@interface CityItems : MTLModel <MTLJSONSerializing>

/**
 縣市 ID
 */
@property (nonatomic, copy) NSString *cityID;

/**
 縣市 名稱
 */
@property (nonatomic, copy) NSString *cityName;

/**
 該縣市內的鄉鎮
 */
@property (nonatomic, copy) NSArray *countrys;


@end

@interface CountryItems : MTLModel <MTLJSONSerializing>

/**
 鄉鎮 ID
 */
@property (nonatomic, copy) NSString *countryID;

/**
 鄉鎮 名稱
 */
@property (nonatomic, copy) NSString *countryName;

/**
 鄉鎮 區
 */
@property (nonatomic, copy) NSString *countryPostal;
@end
