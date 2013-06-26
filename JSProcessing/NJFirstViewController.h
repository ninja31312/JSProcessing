
#import <UIKit/UIKit.h>

@interface NJFirstViewController : UIViewController <UITextViewDelegate>
{
	IBOutlet UITextView *_scriptTextView;
}

- (IBAction)editDone:(id)sender;

@end
