//
//  FileManager.h
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/22.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

/**
 檢查檔案是否已存在document

 @param fileName 檔案名稱
 @return 是否存在
 */
+ (BOOL)checkFileIsExist:(NSString *)fileName;

/**
 回傳document下的檔案

 @param fileName 檔案名稱
 @return document下的檔案
 */
+ (NSString *)documentPathWithFileName:(NSString *)fileName;

/**
 從JSON檔案轉換成JSON Array

 @param fileName 檔案名稱
 @return JSON Array
 */
+ (NSArray *)parseJSONArrayWithFileName:(NSString *)fileName;
@end
