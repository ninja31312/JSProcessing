
#import "NJJavascriptInterpreter.h"

static NJJavascriptInterpreter *jsInterpreter = nil;

@interface NJJavascriptInterpreter(Privates)

- (instancetype)_init;
- (void)_interpretJSFuctionName;

@end

@implementation NJJavascriptInterpreter
{
	JSContext *_jsContext;
}

+(instancetype)sharedLoader
{
    if (!jsInterpreter) {
        jsInterpreter = [[NJJavascriptInterpreter alloc] _init];
    }
    return jsInterpreter;
}

- (void)evaluateJSString:(NSString *)inScriptString
{
    // objc calls javascript
    [_jsContext evaluateScript:inScriptString];
}

#pragma mark -
#pragma mark Private methods

// - (id)init
- (instancetype)_init
{
	self = [super init];
    if (self) {
		_jsContext = [[JSContext alloc] init];
		[self _interpretJSFuctionName];
    }
    return self;
}

- (void)_interpretJSFuctionName
{
	_jsContext[@"color"] = ^(CGFloat red, CGFloat green, CGFloat blue){
        UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
		[color set];
	};
	_jsContext[@"rectFill"] = ^(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
        CGRect rect = CGRectMake(x, y, width, height);
		UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
		[path fill];
	};
    _jsContext[@"rectStroke"] = ^(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
        CGRect rect = CGRectMake(x, y, width, height);
		UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
		[path stroke];
	};
    _jsContext[@"ellipseStroke"] = ^(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
		UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x - width / 2, y - height / 2, width, height)];
		[path stroke];
	};
    _jsContext[@"drawString"] = ^(CGFloat x, CGFloat y, CGFloat width, CGFloat height, NSString *inString){
		CGRect rect = CGRectMake(x, y, width, height);
		[inString drawInRect:rect withAttributes:nil];
	};
    _jsContext[@"rotateLine"] = ^(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2, CGFloat radian){
		UIBezierPath *path = [UIBezierPath bezierPath];
		[path moveToPoint:CGPointMake(x1, y1)];
		double dx = x2 - x1;
		double dy = y2 - y1;
		double distance = sqrt(dx*dx + dy*dy);
		double newX = x1 + distance * cos(M_PI_2 - radian);
		double newY = y1 - distance * sin(M_PI_2 - radian);
		[path addLineToPoint:CGPointMake(newX, newY)];
		[path closePath];
		[path stroke];
	};
	_jsContext[@"canvasWidth"] = ^(){
        return 	[[UIScreen mainScreen] bounds].size.width;
	};
	_jsContext[@"canvasHeight"] = ^(){
        return 	[[UIScreen mainScreen] bounds].size.height;
	};
	_jsContext[@"drawImage"] = ^(CGFloat x, CGFloat y, CGFloat width, CGFloat height, NSString *imageName){
        UIImage *image = [UIImage imageNamed:imageName];
		[image drawInRect:CGRectMake(x, y, width, height)];
	};
	_jsContext[@"log"] = ^(NSString *message){
		NSLog(@"message %@", message);
	};
}

#pragma mark -
#pragma mark NJViewDelegate

- (void)NJViewDidStartDrawRect:(NJView *)inView
{
	JSValue *function = _jsContext[@"draw"];
    [function callWithArguments:nil];
}

@end
