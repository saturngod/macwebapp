//
//  AppDelegate.h
//  Web App
//
//  Created by Htain Lin Shwe on 5/11/12.
//  Copyright (c) 2012 comquas. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSMenu *appmenu;
@property (assign) IBOutlet NSMenuItem *preferenceMenuItem;
@property (assign) IBOutlet NSMenuItem *aboutMenuItem;
@property (assign) IBOutlet NSMenuItem *quitMenuItem;
@property (assign) IBOutlet NSMenuItem *showTitleBarMenuItem;
@property (assign) IBOutlet WebView *webview;
@property (assign) IBOutlet NSProgressIndicator *progress;


-(IBAction)showPreference:(id)sender;
-(IBAction)showTtitleBar:(id)sender;

-(IBAction)ReloadPage:(id)sender;

@end
