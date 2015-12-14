//
//  HBSignalBus.m
//  HBSignal_New
//
//  Created by 星盛 on 15/1/9.
//  Copyright (c) 2015年 星盛. All rights reserved.
//
#define KEY_SEPARATED @"**"
#define KEY_SIGNAL(OBJ,KEY) [[NSString stringWithUTF8String:object_getClassName(object)] stringByAppendingFormat:@"%@%@",KEY_SEPARATED,KEY]
#define KEY_SIGNAL_OBJSTR(TARGETCLSNAME,KEY) [NSString stringWithFormat:@"%@%@%@",TARGETCLSNAME,KEY_SEPARATED,KEY]

#import "HBSignalBus.h"

@implementation  HBSignalBus

+(HBSignalBus *)shareIntance
{
    static dispatch_once_t  onceToken;
    static HBSignalBus * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[HBSignalBus alloc] init];
    });
    return sSharedInstance;
}


+ (NSString *)SIGNAL
{
    return nil;
}
+ (NSString *)SIGNAL_TYPE
{
    return nil;
}

- (void)handleUISignal:(HBSignalBus *)signal
{
    
}

//self key target
-(void)observerWithObject:(id)object key:(NSString *)key target:(id)target
{
     NSString * targetname = NSStringFromClass([target class]);
    [self observerWithObject:object key:key targetclass:targetname];
}

#pragma mark - 监听消息

-(void)observerWithObject:(id)object key:(NSString *)key targetclass:(NSString *)targetclass
{
    NSString * NotificationName = KEY_SIGNAL_OBJSTR(targetclass, key);
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"handelSignal_%@_%@:",targetclass,key]);
    if (object && [object respondsToSelector:selector]) {
        [[NSNotificationCenter defaultCenter]  addObserver:object selector:selector name:NotificationName object:nil];
    }
}

-(void)observerWithObject:(id)observer key:(NSString *)key targetclass:(NSString *)targetclass from:(id)from
{
    NSString * NotificationName = KEY_SIGNAL_OBJSTR(targetclass, key);
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"handelSignal_%@_%@:",targetclass,key]);
    if (observer && [observer respondsToSelector:selector]) {
       [[NSNotificationCenter defaultCenter]  addObserver:observer selector:selector name:NotificationName object:from];
    }
}

-(void)observerWithObject:(id)object key:(NSString *)key
{
    [self observerWithObject:object key:key target:object];
}

-(void)removeObserver:(id)object key:(NSString *)key
{
    [self removeObserver:object key:key targetname:NSStringFromClass([object class])];
}

#pragma mark - 移除通知

-(void)removeObserver:(id)object key:(NSString *)key targetname:(NSString *)targetname
{
    [self removeObserver:object key:key targetname:targetname from:nil];
}

-(void)removeObserver:(id)object key:(NSString *)key targetname:(NSString *)targetname from:(id)from
{
    NSString * NotificationName = KEY_SIGNAL_OBJSTR(targetname, key);
    [[NSNotificationCenter defaultCenter] removeObserver:object name:NotificationName object:from];
}

//加入观察的对象如有handelsignal函数就调用他 否则不调用
/*
*发送消息 根据 source_name找到该消息 调用 handelSignal_ViewController_tap： 方法
*/

- (HBSignalBus *)sendUISignal:(id)source key:(NSString *)name
{
    
    [self sendUISignalwithsourceclassname:NSStringFromClass([source class]) key:name withObject:nil];
  
    return self;
}
//发送消息 source：发送者 key：消息名称  withobject:消息带的参数
/* 监听消息
 * -(void)handelSignal_TopicCacheCenter_NewlyTopicList:(NSNotification *)notify
 */
#pragma mark - 发送通知
- (HBSignalBus *)sendUISignalwithsourceclassname:(NSString *)sourceclassname key:(NSString *)name withObject:(NSObject *)withobject
{
     NSString * NotificationName = KEY_SIGNAL_OBJSTR(sourceclassname, name);
    
    NSLog(@"发送消息 %@",NotificationName);
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationName object:withobject];
    
 
    return self;
}
- (HBSignalBus *)sendUISignal:(id)source key:(NSString *)name withObject:(NSObject *)withobject
{
     NSString * sourcestr = [NSString stringWithUTF8String:object_getClassName(source)];
    [self sendUISignalwithsourceclassname:sourcestr key:name withObject:withobject];
    
 
    return self;
}

 
@end
