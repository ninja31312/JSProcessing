
#import <UIKit/UIKit.h>
@class NJView;

@protocol NJViewDelegate <NSObject>

- (void)NJViewDidInit:(NJView *)inView;
- (void)NJViewDidStartDrawRect:(NJView *)inView;
- (void)NJView:(NJView *)inView didHitPoint:(CGPoint)point;
- (BOOL)NJViewShouldDraw:(NJView *)inView;
@end
@interface NJView : UIView
{
    __weak id <NJViewDelegate> delegate;
}
@property (weak, nonatomic) id <NJViewDelegate> delegate;

@end
