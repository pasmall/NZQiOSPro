//
//  NZQWorkList.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/8.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NZQWorkModel : NSObject<YYModel>

@property (nonatomic , copy) NSString              * zqId;
@property (nonatomic , copy) NSString              * logourl;
@property (nonatomic , copy) NSString              * video;
@property (nonatomic , copy) NSString              * uid;
@property (nonatomic , copy) NSString              * zqDescription;
@property (nonatomic , copy) NSString              * commCount;
@property (nonatomic , copy) NSString              * isCollect;
@property (nonatomic , copy) NSArray<NSString *>              * pictures;
@property (nonatomic , copy) NSString              * collectCount;
@property (nonatomic , copy) NSString              * isFocus;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * transpond;
@property (nonatomic , copy) NSString              * add_Time;
@property (nonatomic , copy) NSString              * long_time;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , assign) NSInteger              picturesNum;
@property (nonatomic , copy) NSString              * headlogourl;
@property (nonatomic , assign) CGFloat              cellHeight;

@end

@interface NZQWorkList :NSObject<YYModel>
@property (nonatomic , copy) NSArray<NZQWorkModel *>              * list;

@end



