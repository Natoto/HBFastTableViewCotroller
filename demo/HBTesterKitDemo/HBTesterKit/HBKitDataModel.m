//
//  HBKitDataModel.m
//  Pods
//
//  Created by HUANGBO on 16/11/30.
//
//

#import "HBKitDataModel.h"
#import "HBCellStruct.h"
#import "HBCellStruct.h"

//@implementation NSObject(hbkit) 
//-(NSString *)key_indexpath:(int)section row:(int)row{
//    return  [NSString stringWithFormat:@"section%u_%u",(int)section,(int)row];
//}
//@end

@implementation HBKitDataModel

-(NSMutableDictionary *)dataDictionary{
    if (!_dataDictionary) {
        _dataDictionary = [NSMutableDictionary new];
    }
    return _dataDictionary;
}
-(NSMutableDictionary *)viewConfigDictionary{
    if (!_viewConfigDictionary) {
        _viewConfigDictionary = [NSMutableDictionary new];
    }
    return _viewConfigDictionary;
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

/**
 * 从绝对路径中加载文件，filepath如果不填默认从系统文件中读取
 */
-(void)loadplistConfig:(NSString *)plistname
              filepath:(NSString *)filepath
       configViewblock:(void(^)( NSMutableDictionary * viewconfigDictionary))configViewblock
{
    NSMutableDictionary * dataDictionary = [self loadplistConfigToDictionary:plistname filepath:filepath];
    if (configViewblock) {
        configViewblock(self.viewConfigDictionary);
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

-(BOOL)containkeys:(NSString *)key{
    
    NSArray * array = @[@"title",@"backgroundcolor",@"backgroundimage"];
    __block  BOOL valiate = NO;
    [array enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([key isEqualToString:obj]) {
            valiate = YES;
            *stop = YES;
        }
    }]; 
    return valiate;
}
/**
 * 从绝对路径中加载文件，filepath如果不填默认从系统文件中读取
 */
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
            else if([self containkeys:key]){
                NSObject * value = dic[key];
                [self.viewConfigDictionary setObject:value forKey:key];
            }
        }
    }
    else{
        NSLog(@"文件不存在 path:%@",filepath);
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
