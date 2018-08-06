//
//  NZQBaseRequest.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/2.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQBaseRequest.h"
#import "NZQRequestManager.h"

@implementation NZQBaseRequest

- (void)GET:(NSString *)URLString parameters:(id)parameters completion:(void(^)(NZQBaseResponse *response))completion
{
    
    NZQWeak(self);
    [[NZQRequestManager sharedManager] GET:URLString parameters:parameters completion:^(NZQBaseResponse *response) {
        
        if (!weakself) {
            return ;
        }
        
        
        !completion ?: completion(response);
        
    }];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters completion:(void(^)(NZQBaseResponse *response))completion
{
    NZQWeak(self);
    [[NZQRequestManager sharedManager] POST:URLString parameters:parameters completion:^(NZQBaseResponse *response) {
        
        if (!weakself) {
            return ;
        }
        
        
        !completion ?: completion(response);
        
    }];
}

@end
