//
//  NZQBaseResponse.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/2.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NZQBaseResponse : NSObject

/** 错误 */
@property (nonatomic, strong) NSError *error;

/** 错误提示 */
@property (nonatomic, copy) NSString *errorMsg;

/** 错误码 */
@property (assign, nonatomic) NSInteger statusCode;

/** 响应头 */
@property (nonatomic, strong) NSMutableDictionary *headers;

/** 响应体 */
@property (nonatomic, strong) id responseObject;

@end
