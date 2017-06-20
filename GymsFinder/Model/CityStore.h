//
//  CityStore.h
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/23.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface CityStore : MTLModel<MTLJSONSerializing>

+ (instancetype)sharedInstance;

@property (nonatomic, copy) NSArray *cityItems;
@property (nonatomic, copy) NSArray *countryItems;

- (void)parseCountryJSONArray:(NSArray *)array;

- (void)clearCountryItems;
@end

@interface CityItems : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *cityName;

@end

@interface CountryItems : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *countryName;

@end
