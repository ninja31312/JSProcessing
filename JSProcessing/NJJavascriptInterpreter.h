
@import Foundation; //#import <Foundation/Foundation.h>
@import JavaScriptCore; //#import <JavascriptCore/JSContext.h>
#import "NJView.h"

@interface NJJavascriptInterpreter : NSObject <NJViewDelegate>
{
    NSString *scriptString;
}

+ (instancetype)sharedInterpreter;

- (void)evaluateJSString:(NSString *)inString;
@end
