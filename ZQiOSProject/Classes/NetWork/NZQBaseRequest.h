//
//  NZQBaseRequest.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/2.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NZQBaseResponse;

@interface NZQBaseRequest : NSObject

- (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(NZQBaseResponse *response))completion;


- (void)POST:(NSString *)URLString parameters:(id)parameters completion:(void(^)(NZQBaseResponse *response))completion;

@end
