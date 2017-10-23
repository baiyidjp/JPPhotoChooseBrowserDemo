//
//  JPPhotoManager.h
//  ThreePic
//
//  Created by Keep丶Dream on 2017/10/20.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol JPPhotoManagerDelegate <NSObject>

/**
 取消选择图片
 */
- (void)imagePickerControllerDidCancel;

/**
 完成选择图片

 @param thumbImages 缩略图
 @param originalImages 原图
 */
- (void)imagePickerControllerDidFinishPickingMediaWithThumbImages:(NSArray *)thumbImages originalImages:(NSArray *)originalImages;
@end

@interface JPPhotoManager : NSObject

/**
 单例

 @return 单例
 */
+ (JPPhotoManager *)sharedPhotoManager;

/**
 启动图片选择器 默认最多选择9个

 @param viewController 当前所在的控制器
 */
- (void)openPhotoListWithController:(UIViewController *)viewController;

/**
 启动图片选择器

 @param viewController 当前所在的控制器
 @param maxImageCount 最大图片选择数(默认可不传,使用上面接口 设为9)
 */
- (void)openPhotoListWithController:(UIViewController *)viewController MaxImageCount:(NSInteger)maxImageCount;

/** deleagte */
@property(nonatomic,weak) id<JPPhotoManagerDelegate> delegate;


@end