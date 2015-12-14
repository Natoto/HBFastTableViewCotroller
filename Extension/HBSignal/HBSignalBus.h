//
//  HBSignalBus.h
//  HBSignal_New
//
//  Created by 星盛 on 15/1/9.
//  Copyright (c) 2015年 星盛. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "HBSignal.h"
//通知类

//监听和移出键盘事件
#define ADDOBSERVER_KEYBOARD_SHOW_NOTIFY(OBJ,SELECTOR) [[NSNotificationCenter defaultCenter] addObserver:OBJ selector:SELECTOR name:UIKeyboardWillShowNotification object:nil];
#define ADDOBSERVER_KEYBOARD_HIDE_NOTIFY(OBJ,SELECTOR) [[NSNotificationCenter defaultCenter] addObserver:OBJ selector:SELECTOR name:UIKeyboardWillHideNotification object:nil];

#define REMOVEOBSERVER_KEYBOARD_SHOW_NOTIFY(OBJ) [[NSNotificationCenter defaultCenter] removeObserver:OBJ name:UIKeyboardWillShowNotification object:nil];
#define REMOVEOBSERVER_KEYBOARD_HIDE_NOTIFY(OBJ) [[NSNotificationCenter defaultCenter] removeObserver:OBJ name:UIKeyboardWillHideNotification object:nil];

//使用默认的方法
#define ADDOBSERVER_KEYBOARD_SHOW_NOTIFY_(OBJ) [[NSNotificationCenter defaultCenter] addObserver:OBJ selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
#define ADDOBSERVER_KEYBOARD_HIDE_NOTIFY_(OBJ) [[NSNotificationCenter defaultCenter] addObserver:OBJ selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

#define ON_KEYBOARD_WILLSHOW(NOTIFY) -(void)keyboardWillShow:(NSNotification *)NOTIFY
#define ON_KEYBOARD_WILLHIDE(NOTIFY) -(void)keyboardWillHide:(NSNotification *)NOTIFY


//自定义通知宏定义

//[[HBSignalBus shareIntance] removeObserver:self key:@"login" targetname:@"D1_LoginViewController"]

// [[HBSignalBus shareIntance] observerWithObject:self key:@"login" targetclass:@"D1_LoginViewController"]; 
/**
 *  监听通知
 *
 *  @param OBJ        自己self
 *  @param KEY        通知的key
 *  @param TARGETNAME 通知来自的类名
 *
 *  @return 监听通知
 */
#define ADD_HBSIGNAL_OBSERVER(OBJ,KEY,TARGETNAME) \
[[HBSignalBus shareIntance] observerWithObject:OBJ key:KEY targetclass:TARGETNAME];

//移除通知方法1 对应监听通知1
#define REMOVE_HBSIGNAL_OBSERVER(OBJ,KEY,TARGETNAME) \
[[HBSignalBus shareIntance] removeObserver:OBJ key:KEY targetname:TARGETNAME];

//第二套通知 带参数 来自哪里的通知------------------------
//#define ADD_HBSIGNAL_OBSERVER2(MINE,KEY,TARGETNAME,FROM) \
[[HBSignalBus shareIntance] observerWithObject:MINE key:KEY targetclass:TARGETNAME from:FROM];

//第二套移除的方法 对应监听通知2 移除来自
//#define REMOVE_HBSIGNAL_OBSERVER2(OBJ,KEY,TARGETNAME,FROM)  \
[[HBSignalBus shareIntance] removeObserver:OBJ key:KEY targetname:TARGETNAME from:FROM];

#define ON_HBSIGNAL( __class, __name, __signal ) \
-(void)handelSignal_##__class##_##__name:(NSNotification *)__signal

#define SEND_HBSIGNAL(SOURCENAME,KEY,OBJECT)  [[HBSignalBus shareIntance] sendUISignalwithsourceclassname:SOURCENAME key:KEY withObject:OBJECT];


#define ADD_NOTIFY_OBSERVER(OBJ,NOTIFYNAME) [[NSNotificationCenter defaultCenter] addObserver:OBJ\
                                         selector:@selector(handelSignal_##NOTIFYNAME:)\
                                             name:NOTIFYNAME\
                                           object:nil];

#define ON_HANDEL_NOTIFY(__name, __signal )\
-(void)handelSignal_##__name:(NSNotification *)__signal

#define REMOVE_NOTIFY_OBSERVER(OBJ,NOTIFYNAME) \
[[NSNotificationCenter defaultCenter] removeObserver:OBJ name:NOTIFYNAME object:nil];


/* 监听消息写法
 * -(void)handelSignal_TopicCacheCenter_NewlyTopicList:(NSNotification *)notify
 */


@interface HBSignalBus:NSObject
+(HBSignalBus *)shareIntance;
+ (NSString *)SIGNAL;
+ (NSString *)SIGNAL_TYPE;

/*
 *发送消息 根据 source_name找到该消息 调用 handelSignal_ViewController_tap： 方法
 */
- (void)handleUISignal:(HBSignalBus *)signal;

- (HBSignalBus *)sendUISignal:(id)source key:(NSString *)name;
/*
 * 发送消息到观察者 object：表上带的参数
 */
- (HBSignalBus *)sendUISignal:(id)source key:(NSString *)name withObject:(NSObject *)object;

/*
 * 发送消息到观察者 object：表上带的参数 sourceclassname:发送者的classname
 */
- (HBSignalBus *)sendUISignalwithsourceclassname:(NSString *)sourceclassname key:(NSString *)name withObject:(NSObject *)withobject;

//- (HBSignal *)sendUISignal:(id)source key:(NSString *)name withObject:(NSObject *)object from:(id)source;

/**
 * 添加监听事件  目标target 观察者 object 事件 key
 */
-(void)observerWithObject:(id)object key:(NSString *)key;

/**
 * 添加监听事件  目标target 观察者 object 事件 key
 */
-(void)observerWithObject:(id)object key:(NSString *)key target:(id)target;
/**
 * 添加监听事件  目标target string 观察者 object 事件 key
 */
-(void)observerWithObject:(id)object key:(NSString *)key targetclass:(NSString *)targetclass;

/**
 *  添加监听事件
 *
 *  @param observer    监听者
 *  @param key         监听到的某key
 *  @param targetclass 监听到某个对象的class string
 *  @param from        是否只监听某个发送者的 nil表示所有的人
 */
-(void)observerWithObject:(id)observer key:(NSString *)key targetclass:(NSString *)targetclass from:(id)from;

/**
 * 移除监听消息 object 本身 key 类
 */
-(void)removeObserver:(id)object key:(NSString *)key;
/**
 * 移除监听消息
 */
-(void)removeObserver:(id)object key:(NSString *)key targetname:(NSString *)targetname;
/**
 *  移除通知
 *
 *  @param object     监听者
 *  @param key        监听的某类的KEY
 *  @param targetname 监听的某个类的类名
 *  @param from       某个发送者
 */
-(void)removeObserver:(id)object key:(NSString *)key targetname:(NSString *)targetname from:(id)from;
/* 监听消息 
 * -(void)handelSignal_TopicCacheCenter_NewlyTopicList:(NSNotification *)notify
 */

@end
