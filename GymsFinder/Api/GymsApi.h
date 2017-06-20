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

+ (void)downloadGymWithCity:(NSString *)city country:(NSString *)country completionHandler:(CompletionHandler)completionHandler;

/**
 取得體育館所有資料

 @param completionHandler 完成
 */
//+ (void)downloadGymAllList:(CompletionHandler)completionHandler;

/**
 取得設施項目

 @param gymKind 設施類型
 @param completionHandler 完成
 */
+ (void)downloadGymTypeListWithGymKind:(NSString *)gymKind completionHandler:(CompletionHandler)completionHandler;

/**
 取得體育館詳細資料

 @param gymID 體育館ID
 @param completionHandler 完成
 */
+ (void)downloadGymWithGymID:(NSString *)gymID completionHandler:(CompletionHandler)completionHandler;
@end
