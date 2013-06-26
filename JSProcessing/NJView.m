
#import "NJView.h"

@implementation NJView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
    [delegate NJViewDidStartDrawRect:self];
}

@synthesize delegate;
@end
