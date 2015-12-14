
#import <Foundation/Foundation.h>

#pragma mark -

@interface NSData(HBExtension)

@property (nonatomic, readonly) NSData *	MD5;
@property (nonatomic, readonly) NSString *	MD5String;

+ (NSString *)fromResource:(NSString *)resName;

@end
