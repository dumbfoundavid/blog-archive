//
//  MyDocument.h
//  CGEventPostingExample
//
//  Created by Jake Petroules on 6/22/11.
//

#import <Cocoa/Cocoa.h>

@interface MyDocument : NSDocument {
@private
    id capsLockEventMonitor;
    id mouseMovementEventMonitor;
    bool wasCapsLockDown;
}

-(void)beginEventMonitoring;
-(void)endEventMonitoring;

-(void)simulateMouseEvent:(CGEventType)eventType;

@end
