//
//  ViewController.m
//  TimerApp
//
//  Created by MrGcGamer on 31.10.21.
//

#import "ViewController.h"

@interface ViewController () {
    NSTimer *_timer;
    BOOL _runnin;
    NSUInteger _count;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)Start:(NSButton *)sender {
    if (_runnin) {
        _runnin = NO;
        [_timer invalidate];
        self.Start.title = @"Start";
    } else {
        _runnin = YES;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerCounter) userInfo:nil repeats:YES];
        self.Start.title = @"Stop";
    }
}
- (IBAction)Reset:(NSButton *)sender {
    NSAlert *alert = [NSAlert new];
//    alert.delegate = self;
    alert.alertStyle = NSAlertStyleWarning;
    alert.messageText = @"Are you sure, you wanna end it all for good?";
    alert.informativeText = @"Ending it all may or may not bless you with massive amounts of relieve and pleasure.";
    [alert addButtonWithTitle:@"End it all."];
    [alert addButtonWithTitle:@"Relieve may wait."];
    
    
    NSInteger pill = [alert runModal];
    
    if (pill == NSAlertFirstButtonReturn) { // red pill
        _count = 0;
        _runnin = NO;
        [_timer invalidate];
        self.Start.title = @"Start";
        [self.TimerLabel setStringValue:@"00 : 00 : 00"];
    } else {
        // nothing but a mere reference to the matrix.
        // Prefectly balanced, as it should be.
    }
}

- (NSString *)stringForCount:(NSInteger)count {
    NSString *ret = [NSString stringWithFormat:@"%02ld : %02ld : %02ld", (count / 3600), ((count % 3600) / 60), ((count % 3600) % 60)];
    return ret;
}

- (void)timerCounter {
    NSString *timeString = [self stringForCount:++_count];
    [self.TimerLabel setStringValue:timeString];
}


@end
