
#import "JSServiceProvider.h"

static JSServiceProvider *jsInterpreter = nil;
NSString *const kSwipeNotification = @"SwipeNotidicationName";

@interface JSServiceProvider(Privates)

- (instancetype)_init;
- (void)_interpretJSFuctionName;
- (void)_setShoudDraw:(BOOL)inShouldDraw;

@end

@implementation JSServiceProvider
{
	JSContext *_jsContext;
	BOOL _isLoop;
}

+(instancetype)sharedInterpreter
{
    if (!jsInterpreter) {
        jsInterpreter = [[JSServiceProvider alloc] _init];
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
		_isLoop = YES;
		_jsContext = [[JSContext alloc] init];
		[self _interpretJSFuctionName];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSwipeAction:) name:kSwipeNotification object:nil];
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
	_jsContext[@"ellipseFill"] = ^(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
		UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(x - width / 2, y - height / 2, width, height)];
		[path fill];
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
	
	_jsContext[@"width"] = [NSNumber numberWithFloat: [[UIScreen mainScreen] bounds].size.width];
	_jsContext[@"height"] = [NSNumber numberWithFloat:[[UIScreen mainScreen] bounds].size.height];
	
	_jsContext[@"drawImage"] = ^(CGFloat x, CGFloat y, CGFloat width, CGFloat height, NSString *imageName){
        UIImage *image = [UIImage imageNamed:imageName];
		[image drawInRect:CGRectMake(x, y, width, height)];
	};
	_jsContext[@"dist"] = ^(CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2){
		double dx = x2 - x1;
		double dy = y2 - y1;
		double distance = sqrt(dx*dx + dy*dy);
		return distance;
	};
	__block id this = self;
	_jsContext[@"loop"] = ^(void){
		[this _setShoudDraw:YES];
	};
	_jsContext[@"noLoop"] = ^(void){
		[this _setShoudDraw:NO];
	};
	_jsContext[@"log"] = ^(NSString *message){
		NSLog(@"message %@", message);
	};
}

- (void)_setShoudDraw:(BOOL)inShouldDraw
{
	_isLoop = inShouldDraw;
}

- (void)handleSwipeAction:(NSNotification*)notification {
    UISwipeGestureRecognizer *swipeGestureRecognizer = [notification object];
    _jsContext[@"currentDirection"] = @([swipeGestureRecognizer direction]);
}

#pragma mark -
#pragma mark NJViewDelegate

- (void)NJViewDidInit:(NJView *)inView
{
	JSValue *function = _jsContext[@"setUp"];
    [function callWithArguments:nil];
}

- (void)NJViewDidStartDrawRect:(NJView *)inView
{
	if (!_isLoop) {
		return;
	}
	JSValue *function = _jsContext[@"draw"];
    [function callWithArguments:nil];
}

- (void)NJView:(NJView *)inView didHitPoint:(CGPoint)point
{
	JSValue *function = _jsContext[@"mousePressed"];
	NSNumber *x = [NSNumber numberWithFloat:point.x];
	NSNumber *y = [NSNumber numberWithFloat:point.y];
	_jsContext[@"mouseX"] = x;
	_jsContext[@"mouseY"] = y;
    [function callWithArguments:nil];
}

- (BOOL)NJViewShouldDraw:(NJView *)inView
{
	return _isLoop;
}

@end
