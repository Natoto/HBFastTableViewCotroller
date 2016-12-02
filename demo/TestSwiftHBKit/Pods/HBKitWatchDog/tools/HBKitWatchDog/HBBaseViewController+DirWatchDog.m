//
//  HBBaseViewController+DirWatchDog.m
//  Pods
//
//  Created by boob on 16/12/2.
//
//

#import "HBBaseViewController+DirWatchDog.h"

#import "HBDirWatchdog.h"

#ifndef	weakify
#if __has_feature(objc_arc)
#define weakify( x )	autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x;
#else	// #if __has_feature(objc_arc)
#define weakify( x )	autoreleasepool{} __block __typeof__(x) __block_##x##__ = x;
#endif	// #if __has_feature(objc_arc)
#endif	// #ifndef	weakify

#ifndef	strongify
#if __has_feature(objc_arc)
#define strongify( x )	try{} @finally{} __typeof__(x) x = __weak_##x##__;
#else	// #if __has_feature(objc_arc)
#define strongify( x )	try{} @finally{} __typeof__(x) x = __block_##x##__;
#endif	// #if __has_feature(objc_arc)
#endif	// #ifndef	@normalize


static char const key_hbkit_watchdog = 'q';
@implementation  HBBaseViewController(DirWatchDog)

-(HBDirWatchdog *)hbkit_watchDog{
    HBDirWatchdog * obj = objc_getAssociatedObject(self, &key_hbkit_watchdog);
    return obj;
}
-(void)setHBKit_WatchDog:(HBDirWatchdog * )watchdog{
    objc_setAssociatedObject(self, &key_hbkit_watchdog, watchdog, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 *  从plist,json等文件中加载配置信息
 *
 *  @param filename  文件名字
 *  @param postfix   文件后缀
 *  @param directory 文件所在的目录
 *
 
 1. 需要在info.plist文件中做如下配置 projectPath $(SRCROOT)/$(TARGET_NAME)
 ---
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <string>$(SRCROOT)/$(TARGET_NAME)</string>
 </plist>
 ---
2. 在工程文件中创建监听的目录 如 resource，将目录拉入工程中，注意Added folders选择Create folder references ,然后选择工程完成
3. 添加此方法，每次按cmd+s会收到一个block，可以在此回调中完成重新配置
4. 所有的实时刷新都只在模拟器中进行
 */
-(void)loadfilesConfig:(NSString *)filename
               postfix:(NSString *)postfix
             directory:(NSString *)directory
                update:(void(^)(NSString * mainScriptPath))block
{
    
#if DEBUG && TARGET_IPHONE_SIMULATOR
    NSString *rootPath = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"projectPath"];
    NSString *scriptRootPath = [rootPath stringByAppendingPathComponent:directory];
    NSString *mainScriptPath ;
    if (postfix.length) {
        mainScriptPath = [NSString stringWithFormat:@"%@/%@.%@", scriptRootPath, filename,postfix];
    }
    else{
         mainScriptPath = [NSString stringWithFormat:@"%@/%@", scriptRootPath, filename];
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:mainScriptPath]) //如果不存在
    {
        NSLog(@"文件不存在 path:%@ \n 请确认info.plist设置一项 key:projectPath  value:$(SRCROOT)/$(TARGET_NAME)",mainScriptPath);
        return;
    }
    
    @weakify(self)
    HBDirWatchdog *watchDog = [[HBDirWatchdog alloc] initWithPath:scriptRootPath update:^{
        @strongify(self)
        if (block) {
            block(mainScriptPath);
        }
    }];
    [watchDog start];
    [self setHBKit_WatchDog:watchDog];
    if ([postfix isEqualToString:@"plist"]) {
        [self loadplistConfig:filename filepath:mainScriptPath];
    }else{
        [self loadjsonfileConfig:filename filepath:mainScriptPath];
    }
    
#else
    NSString *rootPath = [[NSBundle mainBundle] pathForResource:filename ofType:postfix inDirectory:directory];
    [self loadplistConfig:filename filepath:rootPath];
#endif
}
@end

@implementation HBBaseTableViewController(DirWatchDog)

/**
 *  从plist文件中加载配置信息,实时刷新
 */
-(void)loadplistConfig:(NSString *)plistname watch_directory:(NSString *)directory{
    
    @weakify(self)
    [self loadfilesConfig:plistname postfix:@"plist" directory:directory update:^(NSString * mainScriptPath){
        @strongify(self)
        [self loadplistConfig:plistname filepath:mainScriptPath];
        [self configcellstructs];
        [self.tableView reloadData];
    }];
}

/**
 *  从json文件中加载配置信息,实时刷新
 */
-(void)loadjsonfileConfig:(NSString *)jsonname watch_directory:(NSString *)directory{
    
    @weakify(self)
    [self loadfilesConfig:jsonname postfix:@"json" directory:directory update:^(NSString * mainScriptPath){
        @strongify(self)
        [self loadjsonfileConfig:jsonname filepath:mainScriptPath];
        [self configcellstructs];
        [self.tableView reloadData];
    }];
}
@end

@implementation HBBaseCollectionViewController(DirWatchDog)


/**
 *  从plist文件中加载配置信息,实时刷新
 */
-(void)loadplistConfig:(NSString *)plistname watch_directory:(NSString *)directory{
    
    @weakify(self)
    [self loadfilesConfig:plistname postfix:@"plist" directory:directory update:^(NSString * mainScriptPath){
        @strongify(self)
        [self loadplistConfig:plistname filepath:mainScriptPath];
        [self configcellstructs];
        [self.collectionView reloadData];
    }];
}

/**
 *  从json文件中加载配置信息,实时刷新
 */
-(void)loadjsonfileConfig:(NSString *)jsonname watch_directory:(NSString *)directory{
    
    @weakify(self)
    [self loadfilesConfig:jsonname postfix:@"json" directory:directory update:^(NSString * mainScriptPath){
        @strongify(self)
        [self loadjsonfileConfig:jsonname filepath:mainScriptPath];
        [self configcellstructs];
        [self.collectionView reloadData];
    }];
}

@end


