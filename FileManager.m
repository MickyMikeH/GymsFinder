//
//  FileManager.m
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/22.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (BOOL)checkFileIsExist:(NSString *)fileName {
    NSString *txtPath = [FileManager documentPathWithFileName:fileName];
    
    return [[NSFileManager defaultManager] fileExistsAtPath:txtPath];
}

+ (NSArray *)parseJSONArrayWithFileName:(NSString *)fileName {
    NSString *txtPath = [FileManager documentPathWithFileName:fileName];
    
    return [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:txtPath] options: NSJSONReadingMutableContainers error:nil];
}

+ (NSString *)documentPathWithFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

+ (NSDictionary *)dictionaryWithContenOfJSONString:(NSString *)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[fileName stringByDeletingPathExtension] ofType:[fileName pathExtension]];
    
    return [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options: NSJSONReadingMutableContainers error:nil];
}

@end
