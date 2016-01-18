//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TestOpenCV : NSObject
+(NSString *)DetectEdgeWithImage:(UIImage *)image;
+(UIImage *)Gaussian:(UIImage *)image;
+(NSString *)DetectColor:(UIImage *)image;
+(NSString *)DetectArea:(UIImage *)image;
@end