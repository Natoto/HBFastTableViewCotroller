//
//  AppDelegate.m
//  demo
//
//  Created by 跑酷 on 15/8/11.
//  Copyright (c) 2015年 nonato. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property(nonatomic,strong) UIImageView * mainImageView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString * str = @"eef33";
    NSInteger value = str.integerValue;
    NSLog(@"%ld",value);
    // Override point for customization after application launch.
//    self.mainImageView = [UIImageView new];
//    self.mainImageView.frame = [UIScreen mainScreen].bounds;
//    [self.window addSubview:self.mainImageView];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
//    self.mainImageView.hidden = NO;
//    CIContext *context = [CIContext contextWithOptions:nil];
//    UIImage * shapshot = [UIImage imageNamed:@"beauty.png"];//[self snapshotImageAfterScreenUpdates:YES];
//    CIImage *inputImage = [[CIImage alloc] initWithImage:shapshot];
//    // create gaussian blur filter
//    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
//    [filter setValue:inputImage forKey:kCIInputImageKey];
//    [filter setValue:[NSNumber numberWithFloat:10.0] forKey:@"inputRadius"];
//    // blur image
//    CIImage *result = [filter valueForKey:kCIOutputImageKey];
//    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
//    UIImage *image = [UIImage imageWithCGImage:cgImage];
//    CGImageRelease(cgImage);
//    self.mainImageView.image = image;
//    
//    [self.window bringSubviewToFront:self.mainImageView];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    
}

//- (UIImage *)snapshotImage {
//    UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, self.window.opaque, 0);
//    [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return snap;
//}
////iOS 7上UIView上提供了drawViewHierarchyInRect:afterScreenUpdates:来截图，速度比renderInContext:快15倍。
//- (UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates {
//    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
//        return [self snapshotImage];
//    }
//    UIGraphicsBeginImageContextWithOptions(self.window.bounds.size, self.window.opaque, 0);
//    [self.window drawViewHierarchyInRect:self.window.bounds afterScreenUpdates:afterUpdates];
//    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return snap;
//}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.mainImageView.hidden = YES;
//    });
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
