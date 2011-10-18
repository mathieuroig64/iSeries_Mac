//
//  LoginController.h
//  iSeries
//
//  Created by Mathieu ROIG on 10/9/11.
//  Copyright 2011 Apocope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YAJL/YAJL.h>

@interface LoginController : NSViewController{
  NSTextField * loginTextField_;
  NSSecureTextField * passwordTextField_;
  NSButton * loginButton_;
  @private
  NSString * login_;
  NSString * password_;
}

@property (nonatomic, retain) IBOutlet NSTextField * loginTextField;
@property (nonatomic, retain) IBOutlet NSSecureTextField * passwordTextField;
@property (nonatomic, retain) IBOutlet NSButton * loginButton;

- (IBAction)didClickOnIdentification:(id)sender;
- (IBAction)didClickOnCreateAccount:(id)sender;

@end
