//
//  HBKitDataModel.m
//  Pods
//
//  Created by boob on 16/11/30.
//
//

#import "HBKitDataModel.h"
#import "CELL_STRUCT.h"
#import "CELL_STRUCT_Common.h"

@implementation HBKitDataModel

-(NSMutableDictionary *)dataDictionary{
    if (!_dataDictionary) {
        _dataDictionary = [NSMutableDictionary new];
    }
    return _dataDictionary;
}

/**
 *  从PLIST 文件中加载配置信息
 *
 *  @param plistname plist文件的名字
 */
-(void)loadplistConfig:(NSString *)plistname
       configViewblock:(void(^)( NSMutableDictionary * dataDictionary))configViewblock{
    
    [self loadplistConfig:plistname filepath:nil configViewblock:configViewblock];
}

-(void)loadplistConfig:(NSString *)plistname
              filepath:(NSString *)filepath
       configViewblock:(void(^)( NSMutableDictionary * dataDictionary))configViewblock
{
    NSMutableDictionary * dataDictionary = [self loadplistConfigToDictionary:plistname filepath:filepath];
    if (configViewblock) {
        configViewblock(dataDictionary);
    }
    self.dataDictionary = dataDictionary;
}

/**
 *  从PLIST 文件中加载配置信息放到一个字典中而不是直接对datadictionary赋值
 *
 *  @param plistname plist文件的名字
 */

-(NSMutableDictionary *)loadplistConfigToDictionary:(NSString *)plistname{
    return [self loadplistConfigToDictionary:plistname filepath:nil];
}
-(NSMutableDictionary *)loadplistConfigToDictionary:(NSString *)plistname filepath:(NSString *)filepath
{
    NSMutableDictionary * dataDictionary = [NSMutableDictionary new];
    if (!filepath) {
        filepath = [[NSBundle mainBundle] pathForResource:plistname ofType:@"plist"];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //访问【filepath】目录下的问题件，该目录下支持手动增加、修改、删除文件及目录
    if([fileManager fileExistsAtPath:filepath]) //如果存在
    {
        NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filepath];
        for (NSString * key in dic.allKeys) {
            NSDictionary * adic = dic[key];
            if ([key containsString:@"section"] && adic) {
                CELL_STRUCT * cellstruct = [[CELL_STRUCT alloc] initWithPlistDictionary:adic];
                if (cellstruct) {
                    [dataDictionary setObject:cellstruct forKey:key];
                }
            }
        }
    }
   
    return dataDictionary;
}

#pragma mark - load with json


/**
 *  从json文件中配置信息
 *
 *  @param jsonfilepath  json文件存放的路径名
 */

-(void)loadjsonfileConfig:(NSString *)jsonfilename  configViewblock:(void(^)( CELL_STRUCT_ARRAY * vclist))configViewblock{
    [self loadjsonfileConfig:jsonfilename filepath:nil configViewblock:configViewblock];
}

-(void)loadjsonfileConfig:(NSString *)jsonfilename
                 filepath:(NSString *)filepath
          configViewblock:(void(^)( CELL_STRUCT_ARRAY * vclist))configViewblock
{
    if (!filepath) {
        filepath = [[NSBundle mainBundle] pathForResource:jsonfilename ofType:@"json"];
    }
    NSError * error;
    NSString * jsonstring = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    if(error) { // If error object was instantiated, handle it.
        NSLog(@"ERROR while loading from file: %@", error);
        // …
    }
    else{
        CELL_STRUCT_ARRAY * vclist = [[CELL_STRUCT_ARRAY alloc] hb_initWithJSONData:[jsonstring dataUsingEncoding:NSUTF8StringEncoding]];
        NSString * title = vclist.title;
        if (configViewblock) {
            configViewblock(vclist);
        }
        
        [vclist.array enumerateObjectsUsingBlock:^(CELL_STRUCT * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.dictionarystring  = [self URLDecoding:obj.dictionarystring];
            obj.dictionary = [NSMutableDictionary dictionaryWithDictionary: [self dictionaryWithJsonString:obj.dictionarystring]];
            if (obj && [obj.key_indexpath containsString:@"section"] ) {
                [self.dataDictionary setObject:obj forKey:obj.key_indexpath];
            }
        }];
    }
    
    //    NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filepath];
    //    [self loadplistviewConfig:dic];
    
}



/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (NSString *)URLDecoding:(NSString *)sourcestring
{
    if (!sourcestring) {
        return nil;
    }
    NSMutableString * string = [NSMutableString stringWithString:sourcestring];
    [string replaceOccurrencesOfString:@"+"
                            withString:@" "
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, [string length])];
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


@end
