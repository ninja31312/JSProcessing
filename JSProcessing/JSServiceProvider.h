
@import Foundation; //#import <Foundation/Foundation.h>
@import JavaScriptCore; //#import <JavascriptCore/JSContext.h>
#import "NJView.h"
extern NSString *const kSwipeNotification;

@interface JSServiceProvider : NSObject <NJViewDelegate>
{
    NSString *scriptString;
}

+ (instancetype)sharedInterpreter;

- (void)evaluateJSString:(NSString *)inString;

@end
