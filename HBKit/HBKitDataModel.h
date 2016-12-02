//
//  HBKitDataModel.h
//  Pods
//
//  Created by HUANGBO on 16/11/30.
//
//

#import <Foundation/Foundation.h>


#undef KEY_INDEXPATH
#define KEY_INDEXPATH(SECTION,ROW) [NSString stringWithFormat:@"section%u_%u",(int)SECTION,(int)ROW]

#undef  KEY_SECTION
#define KEY_SECTION(SECTION) [NSString stringWithFormat:@"section%d",(int)SECTION]

#undef KEY_SECTION_MARK
#define KEY_SECTION_MARK(SECTION) [NSString stringWithFormat:@"section%d_",(int)SECTION]


#undef KEY_SECTION_INDEX_STR
#define KEY_SECTION_INDEX_STR(INDEXPATHKEY)  ((INDEXPATHKEY.length >9)?[INDEXPATHKEY substringWithRange:NSMakeRange(7, ([INDEXPATHKEY rangeOfString:@"_"].location - 7))]:nil)
//SECTION
#undef KEY_INDEXPATH_SECTION_STR
#define KEY_INDEXPATH_SECTION_STR(INDEXPATHKEY)  ((INDEXPATHKEY.length >9)?[INDEXPATHKEY substringWithRange:NSMakeRange(7, ([INDEXPATHKEY rangeOfString:@"_"].location - 7))]:nil)

//ROW
#undef  KEY_INDEXPATH_ROW_STR
#define KEY_INDEXPATH_ROW_STR(INDEXPATHKEY)  [INDEXPATHKEY substringFromIndex:(([INDEXPATHKEY rangeOfString:@"_"]).location + ([INDEXPATHKEY rangeOfString:@"_"]).length)]


@class CELL_STRUCT_ARRAY;


@interface HBKitDataModel : NSObject

@property(nonatomic,strong) NSMutableDictionary * dataDictionary;
@property(nonatomic,strong) NSMutableDictionary * viewConfigDictionary;

/**
 *  从PLIST 文件中加载配置信息
 *
 *  @param plistname plist文件的名字
 */
-(void)loadplistConfig:(NSString *)plistname
       configViewblock:(void(^)( NSMutableDictionary * dataDictionary))configViewblock;


-(void)loadplistConfig:(NSString *)plistname
              filepath:(NSString *)filepath
       configViewblock:(void(^)( NSMutableDictionary * dataDictionary))configViewblock;



/**
 *  从PLIST 文件中加载配置信息放到一个字典中而不是直接对datadictionary赋值
 *
 *  @param plistname plist文件的名字
 */
-(NSMutableDictionary *)loadplistConfigToDictionary:(NSString *)plistname;
-(NSMutableDictionary *)loadplistConfigToDictionary:(NSString *)plistname filepath:(NSString *)filepath;
/**
 *  从json文件中配置信息
 *
 *  @param jsonfilepath  json文件存放的路径名
 */

-(void)loadjsonfileConfig:(NSString *)jsonfilename
          configViewblock:(void(^)( CELL_STRUCT_ARRAY * vclist))configViewblock;

-(void)loadjsonfileConfig:(NSString *)jsonfilename
                 filepath:(NSString *)filepath
          configViewblock:(void(^)( CELL_STRUCT_ARRAY * vclist))configViewblock;
@end
