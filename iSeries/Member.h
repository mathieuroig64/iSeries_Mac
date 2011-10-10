//
//  Member.h
//  iSeries
//
//  Created by Mathieu ROIG on 10/9/11.
//  Copyright 2011 Apocope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject {
  NSString * login_;
  NSString * token_;
}

@property (nonatomic, retain) NSString * login;
@property (nonatomic, retain) NSString * token;

- (id) initWithDictionnary:(NSDictionary*)dictionnary;

@end
