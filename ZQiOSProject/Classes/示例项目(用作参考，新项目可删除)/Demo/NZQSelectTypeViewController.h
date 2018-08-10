//
//  NZQSelectTypeViewController.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/10.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQBaseViewController.h"

typedef void(^selectTypesBlock)(NSArray *array);

@interface NZQSelectTypeViewController : NZQBaseViewController


- (instancetype)initWithCallBack:(selectTypesBlock)block;

@property (nonatomic,copy)selectTypesBlock zqTypesBlock;

@end
