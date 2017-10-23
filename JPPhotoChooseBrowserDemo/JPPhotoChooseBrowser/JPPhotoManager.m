//
//  JPPhotoManager.m
//  ThreePic
//
//  Created by Keep丶Dream on 2017/10/20.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "JPPhotoManager.h"
#import "JPPhotoGroupListController.h"

@implementation JPPhotoManager


+ (JPPhotoManager *)sharedPhotoManager{
    
    static JPPhotoManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JPPhotoManager alloc]init];
    });
    
    return manager;
}


- (void)openPhotoListWithController:(UIViewController *)viewController {
    
    [self openPhotoListWithController:viewController MaxImageCount:9];
}

- (void)openPhotoListWithController:(UIViewController *)viewController MaxImageCount:(NSInteger)maxImageCount {
    
    JPPhotoGroupListController *photoCtrl = [[JPPhotoGroupListController alloc] init];
    photoCtrl.maxImageCount = maxImageCount;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:photoCtrl];
    [viewController presentViewController:nav animated:YES completion:nil];

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_SendPhoto:) name:@"JPSendPhotoKey" object:nil];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_CancelPhoto:) name:@"JPCancelChoosePhotoKey" object:nil];
    }
    return self;
}
#pragma mark -接收发送图片的通知
- (void)p_SendPhoto:(NSNotification *)notification {
    
    NSDictionary *info = notification.userInfo;
    if ([self.delegate respondsToSelector:@selector(imagePickerControllerDidFinishPickingMediaWithThumbImages:originalImages:)]) {
        [self.delegate imagePickerControllerDidFinishPickingMediaWithThumbImages:[info objectForKey:@"JPThumbImageKey"] originalImages:[info objectForKey:@"JPOriginalImageKey"]];
    }
}

#pragma mark -取消图片选择
- (void)p_CancelPhoto:(NSNotification *)notification {
    
    if ([self.delegate respondsToSelector:@selector(imagePickerControllerDidCancel)]) {
        [self.delegate imagePickerControllerDidCancel];
    }
}


@end