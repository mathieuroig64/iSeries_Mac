//
//  Member.m
//  iSeries
//
//  Created by Mathieu ROIG on 10/9/11.
//  Copyright 2011 Apocope. All rights reserved.
//

#import "Member.h"

@implementation Member
@synthesize login = login_;
@synthesize token = token_;

- (id) initWithDictionnary:(NSDictionary*)dictionnary{
  self = [super init];
  if (self) {
    login_ = [dictionnary objectForKey:@"login"];
    token_ = [dictionnary objectForKey:@"token"];
  }
  return self;
}

- (void) dealloc{
  [login_ release];
  [token_ release];
  [super dealloc];
}

@end
