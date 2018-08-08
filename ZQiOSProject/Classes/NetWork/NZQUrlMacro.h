//
//  STUrlMacro.h
//  MaintainWayPro
//
//  Created by lyric on 2017/8/24.
//  Copyright © 2017年 lyric. All rights reserved.
//

#ifndef NZQUrlMacro_h
#define NZQUrlMacro_h

#define keyID                   @"amp0Nzk1NjA5NTM5QDViNjhmZjcxMTlhYTdAOTZlNzkyMTg5NjVlYjcyYzkyYTU0OWRkNWEzMzAxMTI="
#define userID                  @"111895"

#define BaseUrl                 @"https://cninct.com/" //基础地址

/*建筑定制*/
#define DataBuildMyCommList     @"DataBuildMyCommList" //我的消息评论
#define SeeVideoData            @"SeeVideoData"


#define BaseUrlWith(key)  [NSString stringWithFormat:@"%@%@",BaseUrl,key]

#endif /* STUrlMacro_h */
