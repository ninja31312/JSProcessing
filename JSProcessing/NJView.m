
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

- (void)awakeFromNib
{
	[super awakeFromNib];

	UITapGestureRecognizer *singleFingerTap =
	[[UITapGestureRecognizer alloc] initWithTarget:self
											action:@selector(handleSingleTap:)];
	[self addGestureRecognizer:singleFingerTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
	CGPoint location = [recognizer locationInView:[recognizer.view superview]];

	if ([delegate respondsToSelector:@selector(NJView:didHitPoint:)]) {
		[delegate NJView:self didHitPoint:location];
	}
}

- (void)drawRect:(CGRect)rect
{
	if ([delegate respondsToSelector:@selector(NJViewShouldDraw:)]) {
		if (![delegate NJViewShouldDraw:self]) {
			return;
		}
	}
	[super drawRect:rect];
	if ([delegate respondsToSelector:@selector(NJViewDidStartDrawRect:)]) {
		[delegate NJViewDidStartDrawRect:self];
	}
}

- (void)setNeedsDisplay
{
	if ([delegate respondsToSelector:@selector(NJViewShouldDraw:)]) {
		if (![delegate NJViewShouldDraw:self]) {
			return;
		}
	}
	[super setNeedsDisplay];
}

@synthesize delegate;
@end
