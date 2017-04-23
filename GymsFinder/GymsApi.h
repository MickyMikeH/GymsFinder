//
//  GymsApi.h
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/15.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseApi.h"

@interface GymsApi : BaseApi

//+ (void)startDownLoad:(CompletionHandler)completionHandler;

/**
 取得體育館所有資料
 */
+ (void)downloadGymAllList:(CompletionHandler)completionHandler;

@end
