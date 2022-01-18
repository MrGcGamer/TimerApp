//
//  ViewController.m
//  TimerApp
//
//  Created by MrGcGamer on 31.10.21.
//

#import "ViewController.h"

@interface ViewController () {
    NSDate *_beginning;
    BOOL _runnin;
    NSUserDefaults *_prefs;
    NSTimeInterval _suffering;
    NSTimer *_timer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _prefs = [NSUserDefaults standardUserDefaults];
    _suffering = ([_prefs floatForKey:@"Count"]) ?: 0;
    NSString *timeString = [self stringForCount:_suffering];
    [self.TimerLabel setStringValue:timeString];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(term) name:NSWindowWillCloseNotification object:nil];
//    NSLog(@"%f, %f, %f, %f",frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
}

- (void)viewDidAppear {
    [super viewDidAppear];
    
    NSApplication *app = [NSApplication sharedApplication];
    NSRect frame = app.keyWindow.frame;
    [app.keyWindow setFrame:NSMakeRect(frame.origin.x, frame.origin.y, frame.size.width, 128) display:NO];
}

- (void)term {
    if (_runnin) {
        _runnin = NO;
        [_timer invalidate];
        _suffering = -[_beginning timeIntervalSinceNow];
        [_prefs setValue:[NSNumber numberWithFloat:_suffering] forKey:@"Count"];
    }
    exit(0);
}

- (IBAction)Start:(NSButton *)sender {
    if (_runnin) { // stop it, get some help
        _runnin = NO;
        [_timer invalidate];
        _suffering = -[_beginning timeIntervalSinceNow];
        self.Start.title = @"Start";
        [_prefs setValue:[NSNumber numberWithFloat:_suffering] forKey:@"Count"];
    } else {
        _runnin = YES;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCounter) userInfo:nil repeats:YES];
        _beginning = [NSDate dateWithTimeIntervalSinceNow:-_suffering];
        self.Start.title = @"Stop";
    }
}
- (IBAction)Reset:(NSButton *)sender {
    NSAlert *alert = [NSAlert new];
    alert.alertStyle = NSAlertStyleWarning;
    alert.icon = [NSImage imageNamed:@"AppIcon"];
    alert.messageText = @"Are you sure, you wanna end it all for good?";
    alert.informativeText = @"Ending it all may or may not bless you with massive amounts of relieve and pleasure.";
    [alert addButtonWithTitle:@"End it all."];
    [alert addButtonWithTitle:@"Relieve may wait."];
    
    
    NSInteger pill = [alert runModal];
    
    if (pill == NSAlertFirstButtonReturn) { // red pill
        _runnin = NO;
        [_timer invalidate];
        _suffering = 0;
        self.Start.title = @"Start";
        [self.TimerLabel setStringValue:@"00 : 00 : 00"];
        [_prefs setValue:@0 forKey:@"Count"];
    } else {
        // nothing but a mere reference to the matrix.
        // Prefectly balanced, as it all should be.
    }
}

- (NSString *)stringForCount:(NSInteger)count {
    NSString *ret = [NSString stringWithFormat:@"%02ld : %02ld : %02ld", (count / 3600), ((count % 3600) / 60), ((count % 3600) % 60)];
    return ret;
}

- (void)updateCounter {
    NSTimeInterval time = -[_beginning timeIntervalSinceNow];
    NSString *timeString = [self stringForCount:time];
    [self.TimerLabel setStringValue:timeString];
}


@end
