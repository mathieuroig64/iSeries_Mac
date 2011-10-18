//
//  iSeriesAppDelegate.m
//  iSeries
//
//  Created by Mathieu ROIG on 10/9/11.
//  Copyright 2011 Apocope. All rights reserved.
//

#import "iSeriesAppDelegate.h"

@interface iSeriesAppDelegate (PrivateMethods)
- (NSImage*) buildSelectionImage;
@end

@implementation iSeriesAppDelegate

@synthesize window = window_;
@synthesize leftBar = leftBar_;


-(void)awakeFromNib
{
  [super awakeFromNib];
  //NSRect rectFrame = NSRectFromCGRect(CGRectMake(0, 0, 73, 453));
  leftBar_ = [[EDSideBar alloc] init];
	[leftBar_ setLayoutMode:ECSideBarLayoutTop];
	[leftBar_ setAnimateSelection:YES];
	[leftBar_ setSidebarDelegate:self];
	NSImage * selImage =[self buildSelectionImage];
	[leftBar_ setSelectionImage:selImage];
	[selImage release];
  
  NSArray * titles = [NSArray arrayWithObjects:
                      @"Mon Planning",
                      @"Mes Episodes",
                      @"Mes Séries",
                      @"Mon Compte", nil];
  
  NSArray * images = [NSArray arrayWithObjects:
                      @"icon1-white.png",
                      @"icon1-white.png",
                      @"icon1-white.png",
                      @"icon1-white.png", nil];
  
  NSArray * alternateImages = [NSArray arrayWithObjects:
                               @"icon1-gray.png",
                               @"icon1-gray.png",
                               @"icon1-gray.png",
                               @"icon1-gray.png", nil];
  
  for (int i = 0; i<[titles count]; i++) {
    [leftBar_ addButtonWithTitle:[titles objectAtIndex:i]
                           image:[images objectAtIndex:i] 
                  alternateImage:[alternateImages objectAtIndex:i]];
  }
  [leftBar_ selectButtonAtRow:0];
}

- (void) dealloc{
  [leftBar_ release];
  [super dealloc];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
  NSLog(@"Left Bar : %@", leftBar_);
}


-(NSImage*)buildSelectionImage
{
	// Create the selection image on the fly, instead of loading from a file resource. 
	NSInteger imageWidth=12, imageHeight=22;
	NSImage* destImage = [[NSImage alloc] initWithSize:NSMakeSize(imageWidth,imageHeight)];
	[destImage lockFocus];
	
	
	
	// Constructing the path
  NSBezierPath *triangle = [NSBezierPath bezierPath];
	[triangle setLineWidth:1.0];
  [triangle moveToPoint:NSMakePoint(imageWidth+1, 0.0)];
  [triangle lineToPoint:NSMakePoint( 0, imageHeight/2.0)];
  [triangle lineToPoint:NSMakePoint( imageWidth+1, imageHeight)];
  [triangle closePath];
	[[NSColor controlColor] setFill];
	[[NSColor darkGrayColor] setStroke];
	[triangle fill];
	[triangle stroke];
	[destImage unlockFocus];
	return destImage;
}

#pragma mark EDSideBarDelegate
-(void)sideBar:(EDSideBar*)tabBar didSelectButton:(NSInteger)button
{
  NSLog(@"Button selected: %ld", button);  
}



@end
