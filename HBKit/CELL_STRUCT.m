//
//  CELL_STRUCT.m
//  JXL
//
//  Created by BooB on 15-4-15.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "CELL_STRUCT.h"
#import <objc/runtime.h>


@implementation HBCellStruct

@class HBBaseTableViewCell;
@class HBBaseCollectionViewCell;
-(instancetype)init
{
    self = [super init];
    if (self) {
        self.cellclass = @"HBBaseTableViewCell";
        self.cellheight = 0;
        self.dictionary = [NSMutableDictionary new];
    }
    return self;
}

-(instancetype)initWithtitle:(NSString *)title
                   cellclass:(NSString *)cellclass
                 placeholder:(NSString *)placehoder
                   accessory:(BOOL)accessory
                 sel_selctor:(SEL)selector
                    delegate:(id)delegate
{
    
    self = [super init];
    if (self) {
        //        self.uploadingIndex = 0;
        self.selectionStyle = YES;
        self.uploadobjcts = [NSMutableArray new];
        self.array = [NSMutableArray new];
        self.cellheight = 44.0;
        self.titlecolor = @"black";
        self.title = title;
        self.cellclass = cellclass;
        self.placeHolder = placehoder;
        self.accessory = accessory;
        self.selectionStyle = YES;
        self.sel_selector = selector;
        self.delegate = delegate;
        self.sectionheight = 0;
        self.sectionfont = 13;
        self.titleLabelNumberOfLines = 1;
        self.dictionary = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - copy
- (instancetype)copyWithZone:(NSZone *)zone
{
    CELL_STRUCT *copy = [[[self class] allocWithZone:zone] init];
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    @try {
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            NSString *key=[[NSString alloc] initWithCString:property_getName(property)
                                                   encoding:NSUTF8StringEncoding];
            if ([key isEqualToString:@"sel_selector"]) {
                continue;
            }
            id value = [self valueForKey:key];
            if (value) {
                [copy setValue:value forKey:key];
            }
        }
    }
    @catch (NSException *exception) {
        NSLog(@"😢-->error:copywithzone  %@", exception);
    }
    @finally {
    }
    free(properties);
    copy.sel_selector = self.sel_selector;
    copy.dictionary = [NSMutableDictionary dictionaryWithDictionary:copy.dictionary];
    return copy;
}


-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _dictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    }
    return self;
}

#pragma mark -
-(id)initWithPlistDictionary:(NSDictionary *)plistdic
{
    self = [super init];
    if (self) {
        for ( Class clazzType = [CELL_STRUCT class];; )
        {
            unsigned int		propertyCount = 0;
            objc_property_t *	properties = class_copyPropertyList( clazzType, &propertyCount);
            for ( NSUInteger i = 0; i < propertyCount; i++ )
            {
                const char *	name = property_getName(properties[i]);
                NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
                if([propertyName description])
                {
                    @try {
                        id object = [plistdic valueForKey:propertyName];
                        if (object) {
                            // 1 对其赋值 类型错误不挂掉
                            [self setValue:object forKey:propertyName];
                        }
                    }
                    @catch (NSException *exception) {
                        // 2 捕获类型不匹配 赋值异常
                        NSLog(@"😢-->%@ 类型不匹配 %s\n%@",propertyName, __FUNCTION__, exception);
                    }
                }
            }
            free( properties );
            clazzType = class_getSuperclass( clazzType );
            if ( nil == clazzType )
                break;
        }
        if ([plistdic objectForKey:@"dictionary"]) {
            self.dictionary = [NSMutableDictionary dictionaryWithDictionary:[plistdic objectForKey:@"dictionary"]];
        }
    }
    return self;
}

-(id)initWithJsonString:(NSString *)jsonstring
{
    CELL_STRUCT * cellstruct = [[CELL_STRUCT alloc] hb_initWithJSONData:[jsonstring dataUsingEncoding:NSUTF8StringEncoding]];
    return cellstruct;
}


@end

@implementation CELL_STRUCT_ARRAY

-(id)init{
    self = [super init];
    if (self) {
        [self setValue:@"HBCellStruct" forKeyPath:[NSString stringWithFormat:@"propertyArrayMap.%@",@"array"]];
    }
    return self;
}

@end
/*-------------- plist demo
 
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <dict>
	<key>section0_0</key>
	<dict>
 <key>title</key>
 <string>充值</string>
 <key>detailtitle</key>
 <string>2016-03-16</string>
 <key>cellclass</key>
 <string>HBBaseTableViewCell</string>
 <key>picture</key>
 <string>myaccount2</string>
 <key>sel_selector_str</key>
 <string>selectAction:</string>
 <key>sectionheight</key>
 <integer>20</integer>
 <key>selectionStyle</key>
 <true/>
 <key>cellheight</key>
 <real>44</real>
 <key>accessory</key>
 <true/>
 <key>CellStyleValue</key>
 <integer>2</integer>
 <key>showBottomLine</key>
 <false/>
 <key>showTopLine</key>
 <false/>
 <key>imageCornerRadius</key>
 <false/>
 <key>imageRight</key>
 <false/>
 <key>tempvalue</key>
 <string></string>
 <key>titleLabelNumberOfLines</key>
 <string></string>
 <key>inputAccessoryView</key>
 <string></string>
 <key>dictionary</key>
 <dict/>
 <key>sectionfooter</key>
 <string></string>
 <key>rightComponts</key>
 <string></string>
 <key>sectionHeaderView</key>
 <string></string>
 <key>sectioncolor</key>
 <string></string>
 <key>titlecolor</key>
 <string></string>
 <key>sectionfont</key>
 <string></string>
 <key>value</key>
 <string></string>
 <key>subvalue2</key>
 <string></string>
 <key>xibvalue</key>
 <string></string>
 <key>attributeTitle</key>
 <string></string>
 <key>titlefontsize</key>
 <string></string>
 <key>array</key>
 <string></string>
 <key>picturecolor</key>
 <string></string>
 <key>textAlignment</key>
 <string></string>
 <key>placeHolder</key>
 <string></string>
 <key>key_indexpath</key>
 <string></string>
 <key>sectiontitle</key>
 <string></string>
 <key>cellctr</key>
 <string></string>
 <key>sectionfooterheight</key>
 <string></string>
 <key>uploadingIndex</key>
 <string></string>
 <key>uploadobjcts</key>
 <string></string>
 <key>object2</key>
 <string></string>
 <key>inputView</key>
 <string></string>
 <key>rightValue</key>
 <string></string>
	</dict>
 </dict>
 </plist>
 
 */
