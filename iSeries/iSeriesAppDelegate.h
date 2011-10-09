//
//  iSeriesAppDelegate.h
//  iSeries
//
//  Created by Mathieu ROIG on 10/9/11.
//  Copyright 2011 Apocope. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface iSeriesAppDelegate : NSObject <NSApplicationDelegate> {
  NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
