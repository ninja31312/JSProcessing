
#import "NJSecondViewController.h"
#import "NJJavascriptInterpreter.h"

@implementation NJSecondViewController
{
    NSTimer *_timer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NJView *view = (NJView *)self.view;
    view.delegate = [NJJavascriptInterpreter sharedLoader];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self.view selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_timer invalidate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
