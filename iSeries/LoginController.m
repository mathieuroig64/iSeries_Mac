//
//  LoginController.m
//  iSeries
//
//  Created by Mathieu ROIG on 10/9/11.
//  Copyright 2011 Apocope. All rights reserved.
//

#import "LoginController.h"
#import "URL.h"
#import "Constant.h"
#import "ASIHTTPRequest.h"
#import "NSString+MD5.h"

@interface LoginController (PrivateMethods)
- (void) showAlertPanelWithMessage:(NSString*)message;
@end

@implementation LoginController
@synthesize loginButton = loginButton_;
@synthesize loginTextField = loginTextField_;
@synthesize passwordTextField = passwordTextField_;

- (id)init
{
  self = [super init];
  if (self) {
    // Initialization code here.
  }
  
  return self;
}

- (IBAction)didClickOnIdentification:(id)sender{
  NSLog(@"Click on id");
  NSString * urlStr = [NSString stringWithFormat:@"%@?key=%@&login=%@&password=%@",
                       kURLAuthentification, 
                       kKeyBetaSeries,
                       [loginTextField_ stringValue],
                       [[passwordTextField_ stringValue] MD5]];
  
  NSURL *url = [NSURL URLWithString:urlStr];
  __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
  [request setCompletionBlock:^{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    [self showAlertPanelWithMessage:responseString];
  }];
  [request setFailedBlock:^{
    NSError *error = [request error];
  }];
  [request startAsynchronous];
}


- (void) showAlertPanelWithMessage:(NSString*)message{
  NSAlert * alertPanel = [NSAlert alertWithMessageText:@"Message"
                                         defaultButton:@"Ok"
                                       alternateButton:nil
                                           otherButton:nil
                             informativeTextWithFormat:message];
  [alertPanel beginSheetModalForWindow:self
                         modalDelegate:self
                        didEndSelector:nil
                           contextInfo:nil];
}

- (void) dealloc{
  [loginTextField_ release];
  [passwordTextField_ release];
  [loginButton_ release];
  [super dealloc];
}

@end
