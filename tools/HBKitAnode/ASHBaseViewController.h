//
//  HBASViewController.h
//  HBCircleWidthDemo
//
//  Created by boob on 16/11/30.
//  Copyright © 2016年 YY.COM. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import <HBKit/HBKit.h>

@interface ASHBaseViewController : ASViewController
@property (nonatomic, strong) HBKitDataModel * datamodel;

@property (nonatomic, strong) ASTableNode * tableView;

@property (nonatomic, strong)  NSMutableDictionary * dataDictionary;

/**
 *  从plist 文件中加载配置信息
 *
 *  @param plistname plist文件的名字
 */
-(void)loadplistConfig:(NSString *)plistname;

/**
 *  从plist文件中加载配置信息放到一个字典中而不是直接对datadictionary赋值
 *
 *  @param plistname plist文件的名字
 */
-(NSMutableDictionary *)loadplistConfigToDictionary:(NSString *)plistname;


/**
 *  从json文件中配置信息
 * 
 */
-(void)loadjsonfileConfig:(NSString *)jsonfilename;

-(void)loadplistConfig:(NSString *)plistname filepath:(NSString *)filepath;

-(NSMutableDictionary *)loadplistConfigToDictionary:(NSString *)plistname filepath:(NSString *)filepath;

-(void)loadjsonfileConfig:(NSString *)jsonfilename filepath:(NSString *)filepath;

@end
