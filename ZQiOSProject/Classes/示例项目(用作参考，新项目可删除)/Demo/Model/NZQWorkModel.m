//
//  NZQWorkList.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/8.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQWorkModel.h"

const CGFloat NZQTopSpace = 15;
const CGFloat NZQImageBgViewHeigth = 200;
const CGFloat NZQIconHeigth = 30;
const CGFloat NZQTextSpace = 8;



@implementation NZQWorkModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"zqId" : @"id",
             @"zqDescription" : @"description",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"pictures" : NSString.class};
}

- (CGFloat)cellHeight{
    if (_cellHeight == 0) {
        _cellHeight = NZQTopSpace*3 + NZQImageBgViewHeigth + NZQIconHeigth + NZQTextSpace*2 + [_title heightForFont:[UIFont systemFontOfSize:15] width:kScreenWidth - NZQTopSpace*2];
    }
    return _cellHeight;
}

@end

@implementation NZQWorkList

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : NZQWorkModel.class};
}

@end
