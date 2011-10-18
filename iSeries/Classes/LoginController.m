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
#import "Member.h"

@interface LoginController (PrivateMethods)
- (BOOL) verifyParameters;
- (void) showAlertPanelWithTitle:(NSString*)title
                      andMessage:(NSString*)message;
- (Member*) retrieveMemberWithResponse:(NSDictionary*)dictionnary;
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





- (void) showAlertPanelWithTitle:(NSString*)title
                      andMessage:(NSString*)message{
  NSAlert * alertPanel = [NSAlert alertWithMessageText:title
                                         defaultButton:@"Ok"
                                       alternateButton:nil
                                           otherButton:nil
                             informativeTextWithFormat:message];
  [alertPanel beginSheetModalForWindow:self
                         modalDelegate:self
                        didEndSelector:nil
                           contextInfo:nil];
}

- (Member*) retrieveMemberWithResponse:(NSDictionary*)dictionnary{
  NSDictionary * rootDict = [dictionnary objectForKey:@"root"];
  NSDictionary * errors = [rootDict objectForKey:@"errors"];
  
  if ([[errors allValues] count] > 0) {
    NSString * errorMessage = [errors objectForKey:@"error"];
    [self showAlertPanelWithTitle:@"Erreur lors de l'identification"
                       andMessage:errorMessage];
    return nil;
  }
  
  NSDictionary * memberDict = [rootDict objectForKey:@"member"];
  Member * member = [[Member alloc] 
                     initWithDictionnary:memberDict];
  return member;
}

- (BOOL) verifyParameters{
  if ([login_ length] > 0
      && [password_ length] > 0) {
    return YES;
  }else{
    [self showAlertPanelWithTitle:@"Login et mot de passe" 
                       andMessage:@"Veuillez spécifier le login et le mot de passe de votre compte"];
    return NO;    
  }
}

#pragma mark IBAction
- (IBAction)didClickOnIdentification:(id)sender{
  //Save login+password
  [login_ release];
  login_ = [[loginTextField_ stringValue] retain];
  [password_ release];
  password_ = [[passwordTextField_ stringValue] retain];
  
  if ([self verifyParameters]) {
    NSString * urlStr = [NSString stringWithFormat:@"%@?key=%@&login=%@&password=%@",
                         kURLAuthentification, 
                         kKeyBetaSeries,
                         login_,
                         [password_ MD5]];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setCompletionBlock:^{
      // Use when fetching text data
      NSString *responseString = [request responseString];
      NSDictionary * responseDict = [responseString yajl_JSON];
      [self retrieveMemberWithResponse:responseDict];
    }];
    [request setFailedBlock:^{
      NSError *error = [request error];
      NSLog(@"Erreur : %@", error);
    }];
    [request startAsynchronous];
  }
}

- (IBAction)didClickOnCreateAccount:(id)sender {
  NSURL * urlCreateAccount = [NSURL URLWithString:kURLCreateAccount];
  [[NSWorkspace sharedWorkspace] openURL:urlCreateAccount];
}

- (void) dealloc{
  [loginTextField_ release];
  [passwordTextField_ release];
  [loginButton_ release];
  [login_ release];
  [password_ release];
  [super dealloc];
}

@end
