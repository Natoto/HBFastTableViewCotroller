//
//  CELL_STRUCT.m
//  JXL
//
//  Created by BooB on 15-4-15.
//  Copyright (c) 2015年 BooB. All rights reserved.
//

#import "CELL_STRUCT.h" 
#import <objc/runtime.h>

@implementation CELL_STRUCT
-(id)initWithtitle:(NSString *)title cellclass:(NSString *)cellclass placeholder:(NSString *)placehoder accessory:(BOOL)accessory sel_selctor:(SEL)selector delegate:(id)delegate
{
    self = [super init];
    if (self) {
        self.uploadingIndex = 0;
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

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _dictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    }
    return self;
}
 
-(id)initWithPlistDictionary:(NSDictionary *)plistdic
{
    self = [super init];
    if (self) {
//        Class rootClass = [self class];
        for ( Class clazzType = [self class];; )
        { 
            unsigned int		propertyCount = 0;
            objc_property_t *	properties = class_copyPropertyList( clazzType, &propertyCount);            
            for ( NSUInteger i = 0; i < propertyCount; i++ )
            {
                const char *	name = property_getName(properties[i]);
                NSString *		propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
                if([propertyName description])
                {
                    NSObject * object = plistdic[propertyName];
                    if (object) {
                        [self setValue:object forKey:propertyName];
                    }
                }
            }
            free( properties );
            clazzType = class_getSuperclass( clazzType );
            if ( nil == clazzType )
                break;
        }
    }
    return self;
}


@end
