//
//  CityApi.h
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/22.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseApi.h"

@interface CityApi : BaseApi

/**
 取得所有市、區資料
 */
+ (void)downloadAllCityAndCountry:(CompletionHandler)completionHandler;;

@end
