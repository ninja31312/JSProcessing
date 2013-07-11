
#import "NJSecondViewController.h"
#import "NJJavascriptInterpreter.h"

@implementation NJSecondViewController
{
    NSTimer *_timer;
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer*)recognizer {
    [[NSNotificationCenter defaultCenter] postNotificationName:kSwipeNotification object:recognizer];
//    [self.view removeGestureRecognizer:recognizer];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NJView *view = (NJView *)self.view;
    view.delegate = [NJJavascriptInterpreter sharedInterpreter];
    [self addGestureRecognizerByDirection:UISwipeGestureRecognizerDirectionRight];
    [self addGestureRecognizerByDirection:UISwipeGestureRecognizerDirectionLeft];
    [self addGestureRecognizerByDirection:UISwipeGestureRecognizerDirectionUp];
    [self addGestureRecognizerByDirection:UISwipeGestureRecognizerDirectionDown];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)addGestureRecognizerByDirection:(UISwipeGestureRecognizerDirection)dir
{
    UISwipeGestureRecognizer* recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    recognizer.direction = dir;
    [self.view addGestureRecognizer:recognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self.view selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
	NJView *view = (NJView *)self.view;
	if ([view.delegate respondsToSelector:@selector(NJViewDidInit:)]) {
		[view.delegate NJViewDidInit:view];
	}
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
