//
//  iSeriesAppDelegate.h
//  iSeries
//
//  Created by Mathieu ROIG on 10/9/11.
//  Copyright 2011 Apocope. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EDSideBar.h"

@interface iSeriesAppDelegate : NSObject 
<NSApplicationDelegate, EDSideBarDelegate> {
  NSWindow *window_;
  EDSideBar *leftBar_;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet EDSideBar *leftBar;

@end
