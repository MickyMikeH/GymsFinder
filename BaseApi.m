//
//  BaseApi.m
//  GymsFinder
//
//  Created by Michael Hsieh on 2017/4/22.
//  Copyright © 2017年 Michael Hsieh. All rights reserved.
//

#import "BaseApi.h"
#import "FileManager.h"
#import <AFNetworking.h>

NSTimeInterval const TIME_OUT = 3.0f;

@implementation BaseApi

+ (void)downloadFileWithFileName:(NSString *)fileName URLstring:(NSString *)URLstring isPost:(BOOL)isPost completionHandler:(CompletionHandler)completionHandler {
    
    if (![FileManager checkFileIsExist:[NSString stringWithFormat:@"%@.json", fileName]]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSURLRequest *request = nil;
        if (isPost) {
            request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLstring parameters:fileName error:nil];
        }
        else {
            NSURL *url = [[NSURL alloc] initWithString:URLstring];
            request = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:TIME_OUT];
        }

        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            
            return [[documentsDirectoryURL URLByAppendingPathComponent:fileName] URLByAppendingPathExtension:@"json"];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            NSLog(@"File downloaded to: %@", filePath);
            
            completionHandler (error);
        }];
        
        [downloadTask resume];
    }
    else {
    
        completionHandler (nil);
    }
}

@end
