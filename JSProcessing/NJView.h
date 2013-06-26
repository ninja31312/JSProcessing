
#import <UIKit/UIKit.h>
@class NJView;

@protocol NJViewDelegate <NSObject>

- (void)NJViewDidStartDrawRect:(NJView *)inView;

@end
@interface NJView : UIView
{
    __weak id <NJViewDelegate> delegate;
}
@property (weak, nonatomic) id <NJViewDelegate> delegate;

@end
