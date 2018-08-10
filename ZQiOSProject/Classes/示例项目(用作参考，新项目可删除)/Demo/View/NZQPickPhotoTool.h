//
//  NZQPickPhotoTool.h
//  ZQiOSProject
//
//  Created by Lyric on 2018/8/9.
//  Copyright © 2018年 Lyric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface NZQPickPhotoTool : NSObject

+ (void)showPickPhotoToolWithViewController:(UIViewController *)viewController maxPhotoCount:(NSUInteger)maxPhotoCount choosePhotoHandler:(void(^)(NSMutableArray<UIImage *> *selectedImages, NSMutableArray<PHAsset *> *selectedAccest))choosePhotoHandler takePhotoHandler:(void(^)(NSMutableArray<UIImage *> *selectedImages, NSMutableArray<PHAsset *> *selectedAccest))takePhotoHandler deleteImage:(void(^)(void(^deleteHandler)(NSUInteger index)))deleteImage;

@end

@interface UIViewController (NZQImagePickTool)
@property (nonatomic, strong, readonly) NSMutableArray<UIImage *> *nzq_selectedImages;
@property (nonatomic, strong, readonly) NSMutableArray<PHAsset *> *nzq_selectedAccests;
@end
