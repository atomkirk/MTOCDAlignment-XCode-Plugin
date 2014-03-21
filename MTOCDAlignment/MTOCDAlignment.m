//
//  MTOCDAlignment.m
//  MTOCDAlignment
//
//  Created by Adam Kirk on 6/15/13.
//  Copyright (c) 2013 Mysterious Trousers. All rights reserved.
//

#import "MTOCDAlignment.h"
#import "MTOCDAligner.h"


@interface MTOCDAlignment ()
@property (nonatomic, strong) NSTextView *textView;
@property (nonatomic, assign) NSRange selectedStringRange;
@property (nonatomic, copy) NSString *selectedStringContent;
@end


@implementation MTOCDAlignment

+ (void)pluginDidLoad:(NSBundle *)plugin
{
	static id sharedPlugin = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedPlugin = [[self alloc] init];
	});
}

- (id)init {
	if (self = [super init]) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidFinishLaunching:) name:NSApplicationDidFinishLaunchingNotification object:nil];
		_selectedStringRange = NSMakeRange(NSNotFound, 0);
	}
	return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [self addMenuItem];
    [self subscribeToNotifications];
}




#pragma mark - Text Selection Handling

- (void)selectionDidChange:(NSNotification *)notification {
	if ([[notification object] isKindOfClass:NSClassFromString(@"DVTSourceTextView")] && [[notification object] isKindOfClass:[NSTextView class]]) {
		self.textView = (NSTextView *)[notification object];

		NSArray *selectedRanges = [self.textView selectedRanges];
		if (selectedRanges.count >= 1) {
            NSRange selectedRange      = [[selectedRanges objectAtIndex:0] rangeValue];
            NSString *text             = self.textView.textStorage.string;
            self.selectedStringRange   = [text lineRangeForRange:selectedRange];
            self.selectedStringContent = [text substringWithRange:_selectedStringRange];
		}
	}
}



#pragma mark - Actions

- (void)alignTextOCDStyle:(id)sender
{
    if (_selectedStringContent && [_selectedStringContent length] >= 2) {
        NSRange currentSelectedRange    = [self.textView selectedRange];
        NSString *alignedText           = [self alignedString];

        [self.textView.undoManager beginUndoGrouping];
        [self.textView insertText:alignedText replacementRange:_selectedStringRange];
        [self.textView.undoManager endUndoGrouping];

        currentSelectedRange.length = MIN(currentSelectedRange.length, [alignedText length]);
        if (currentSelectedRange.location != NSNotFound) {
            [self.textView setSelectedRange:currentSelectedRange];
        }
    }
}






#pragma mark - Private

- (void)addMenuItem
{
    // add menu item
	NSMenuItem *editMenuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
	if (editMenuItem) {
		[[editMenuItem submenu] addItem:[NSMenuItem separatorItem]];

        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"Align Text OCD Style" action:@selector(alignTextOCDStyle:) keyEquivalent:@"a"];
        item.keyEquivalentModifierMask = NSControlKeyMask;
        [item setTarget:self];
        [[editMenuItem submenu] addItem:item];
	}
}

- (void)subscribeToNotifications
{
    // register for notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectionDidChange:) name:NSTextViewDidChangeSelectionNotification object:nil];
    if (!self.textView) {
		NSResponder *firstResponder = [[NSApp keyWindow] firstResponder];
		if ([firstResponder isKindOfClass:NSClassFromString(@"DVTSourceTextView")] && [firstResponder isKindOfClass:[NSTextView class]]) {
			self.textView = (NSTextView *)firstResponder;
		}
	}
	if (self.textView) {
		NSNotification *notification = [NSNotification notificationWithName:NSTextViewDidChangeSelectionNotification object:self.textView];
		[self selectionDidChange:notification];

	}
}

- (NSString *)alignedString
{
    MTOCDAligner *aligner = [MTOCDAligner new];
    return [aligner alignedString:_selectedStringContent];
}


@end
