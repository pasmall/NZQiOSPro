//
//  NZQFileManager.m
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/13.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import "NZQFileManager.h"

@implementation NZQFileManager

+(NSString *)rootDirDoc{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *rootDir = [documentsDirectory stringByAppendingPathComponent:@"RootFileCache"];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:rootDir withIntermediateDirectories:YES attributes:nil error:nil];
    
    return rootDir;
    
}


+(NSString *)rootDirLib{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = paths.firstObject;
    NSString *rootDir = [libraryDirectory stringByAppendingPathComponent:@"RootFileCache"];
    [[NSFileManager defaultManager] createDirectoryAtPath:rootDir withIntermediateDirectories:YES attributes:nil error:nil];
    
    return rootDir;
    
}

+(NSString *)rootDirCache{
    
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *cachePath = [cacPath objectAtIndex:0];
    
    NSString *rootDir = [cachePath stringByAppendingPathComponent:@"RootFileCache"];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:rootDir withIntermediateDirectories:YES attributes:nil error:nil];
    
    return rootDir;
    
}

+(NSString *)rootDirTmp{
    
    NSString *tmpDirectory = NSTemporaryDirectory();
    
    NSString *rootDir = [tmpDirectory stringByAppendingPathComponent:@"RootFileCache"];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:rootDir withIntermediateDirectories:YES attributes:nil error:nil];
    
    return rootDir;
    
}



@end
