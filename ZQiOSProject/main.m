//
//  main.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/2.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NZQAppDelegate.h"

void UncaughtExceptionHandler(NSException *exception);

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
//        @try {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([NZQAppDelegate class]));
//        } @catch (NSException *exception) {
//            UncaughtExceptionHandler(exception);
//        } @finally {
//        }
    
        
    }
}


//接收崩溃信息
void UncaughtExceptionHandler(NSException *exception) {
    NSLog(@"%@",exception);
}
