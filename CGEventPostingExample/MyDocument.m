//
//  MyDocument.m
//  CGEventPostingExample
//
//  Created by Jake Petroules on 6/22/11.
//

#import "MyDocument.h"
#import <Carbon/Carbon.h>

@implementation MyDocument

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
        [self beginEventMonitoring];
    }
    return self;
}

// Begin listening for caps lock key presses and mouse movements
- (void)beginEventMonitoring
{
    // Determines whether the caps lock key was initially down before we started listening for events
    wasCapsLockDown = CGEventSourceKeyState(kCGEventSourceStateHIDSystemState, kVK_CapsLock);

    capsLockEventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:(NSFlagsChangedMask) handler: ^(NSEvent *event)
    {
        // Determines whether the caps lock key was pressed and posts a mouse down or mouse up event depending on its state
        bool isCapsLockDown = [event modifierFlags] & NSAlphaShiftKeyMask;
        if (isCapsLockDown && !wasCapsLockDown)
        {
            [self simulateMouseEvent: kCGEventLeftMouseDown];
            wasCapsLockDown = true;
        }
        else if (wasCapsLockDown)
        {
            [self simulateMouseEvent: kCGEventLeftMouseUp];
            wasCapsLockDown = false;
        }
    }];

    mouseMovementEventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:(NSMouseMovedMask) handler:^(NSEvent *event)
    {
        [self simulateMouseEvent: kCGEventLeftMouseDragged];
    }];
}

// Cease listening for caps lock key presses and mouse movements
- (void)endEventMonitoring
{
    if (capsLockEventMonitor)
    {
        [NSEvent removeMonitor: capsLockEventMonitor];
        capsLockEventMonitor = nil;
    }

    if (mouseMovementEventMonitor)
    {
        [NSEvent removeMonitor: mouseMovementEventMonitor];
        mouseMovementEventMonitor = nil;
    }
}

-(void)simulateMouseEvent:(CGEventType)eventType
{
    // Get the current mouse position
    CGEventRef ourEvent = CGEventCreate(NULL);
    CGPoint mouseLocation = CGEventGetLocation(ourEvent);

    // Create and post the event
    CGEventRef event = CGEventCreateMouseEvent(CGEventSourceCreate(kCGEventSourceStateHIDSystemState), eventType, mouseLocation, kCGMouseButtonLeft);
    CGEventPost(kCGHIDEventTap, event);
    CFRelease(event);
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError {
    /*
     Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    */
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
    }
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
    /*
    Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    */
    if (outError) {
        *outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
    }
    return YES;
}

@end
