
#import "NJFirstViewController.h"
#import "NJJavascriptInterpreter.h"

@implementation NJFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSString *path = [[NSBundle mainBundle] pathForResource:@"/checkeredFlag" ofType:@"js"];
    NSString *defaultString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    [_scriptTextView setText:defaultString];
	[[NJJavascriptInterpreter sharedLoader] evaluateJSString:_scriptTextView.text];
    
    [self _registerObsever];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)_registerObsever
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChange:(UITextView *)textView
{
	[[NJJavascriptInterpreter sharedLoader] evaluateJSString:_scriptTextView.text];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    CGRect textViewRect = _scriptTextView.frame;
    NSDictionary* d = [notification userInfo];
    CGRect r = [d[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    r = [_scriptTextView convertRect:r fromView:nil];
    textViewRect.size.height = r.origin.y;
    [_scriptTextView setFrame:textViewRect];
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    [_scriptTextView setFrame:[self.view bounds]];
}

- (IBAction)editDone:(id)sender
{
    [_scriptTextView resignFirstResponder];
}
@end
