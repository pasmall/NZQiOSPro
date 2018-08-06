//
//  NZQRequestManager.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/2.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "NZQBaseResponse.h"
#import <AFNetworking.h>

typedef NSString NZQDataName;

typedef enum : NSInteger {
    // 自定义错误码
    NZQRequestManagerStatusCodeCustomDemo = -10000,
} NZQRequestManagerStatusCode;

typedef NZQBaseResponse *(^ResponseFormat)(NZQBaseResponse *response);

@interface NZQRequestManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

//本地数据模式
@property (assign, nonatomic) BOOL isLocal;

//预处理返回的数据
@property (copy, nonatomic) ResponseFormat responseFormat;

// https 验证
@property (nonatomic, copy) NSString *cerFilePath;

- (void)POST:(NSString *)urlString parameters:(id)parameters completion:(void (^)(NZQBaseResponse *response))completion;

- (void)GET:(NSString *)urlString parameters:(id)parameters completion:(void (^)(NZQBaseResponse *response))completion;

/*
 上传
 data 数据对应的二进制数据
 NZQDataName data对应的参数
 */
- (void)upload:(NSString *)urlString parameters:(id)parameters formDataBlock:(NSDictionary<NSData *, NZQDataName *> *(^)(id<AFMultipartFormData> formData, NSMutableDictionary<NSData *, NZQDataName *> *needFillDataDict))formDataBlock progress:(void (^)(NSProgress *progress))progress completion:(void (^)(NZQBaseResponse *response))completion;

@end
