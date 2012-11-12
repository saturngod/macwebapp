//
//  AppDelegate.m
//  Web App
//
//  Created by Htain Lin Shwe on 5/11/12.
//  Copyright (c) 2012 comquas. All rights reserved.
//

#import "AppDelegate.h"
#import "preferenceWindowController.h"


@interface AppDelegate()
@property (nonatomic,strong) preferenceWindowController* pref;

/**
 Init App Name In Menu
 */
-(void)setAppName:(NSString*)appname;

/**
 Enable the Title Bar on Windows
 */
-(void)showTitleBarEnable;

/**
 Disable the Title Bar on Windows
 */
-(void)showTitleBarDisable;
@end

@implementation AppDelegate
@synthesize webview = _webview;
@synthesize pref = _pref;
@synthesize progress = _progress;
@synthesize appmenu = _appmenu;
@synthesize showTitleBarMenuItem = _showToolbarMenuItem;

-(preferenceWindowController*)pref
{
    if(_pref == nil) {
        _pref = [[preferenceWindowController alloc] initWithWindowNibName:@"preferenceWindowController"];
    }
    return _pref;
}

-(void)setAppName:(NSString*)appname
{
    [self.window setTitle:appname];
    [self.appmenu setTitle:appname];
    
    [self.aboutMenuItem setTitle:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"About", @""),appname]];
    [self.quitMenuItem setTitle:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Quit", @""),appname]];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];
    
    [self setAppName:[dict objectForKey:@"App Name"]];
    
    if([dict objectForKey:@"Zoom At Start"])
    {
        //maximum
        self.window.isZoomed = YES;
    }
    [self.window setBackgroundColor:[NSColor lightGrayColor]];
    [self.webview setDrawsBackground:NO];
    
    //show or not preference
    if((BOOL)[dict objectForKey:@"Show Preference"] == NO)
    {
        //remove the preference
        [self.appmenu removeItem:self.preferenceMenuItem];
    }
    
    if((BOOL)[dict objectForKey:@"Show TitleBar At Start"] == NO)
    {
        //remove the preference
        [self showTitleBarDisable];
    }
    else {
        [self showTitleBarEnable];
    }
    
    NSString* URL = [dict objectForKey:@"URL"];
    
    //if already have other URL from perference
    if(![Util isEmpty:[[NSUserDefaults standardUserDefaults] objectForKey:@"URL"]])
    {
        URL = [[NSUserDefaults standardUserDefaults] objectForKey:@"URL"];
    }
    
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:URL]];
    
    [self.webview setFrameLoadDelegate:self];
    
    [[self.webview mainFrame] loadRequest:request];
    [self.progress startAnimation:self];
}

-(IBAction)showPreference:(id)sender {
    
    [self.pref showWindow:sender];
    
}


#pragma mark - WebFrameDelegate
- (void)webView:(WebView *)sender didReceiveTitle:(NSString *)title
       forFrame:(WebFrame *)frame
{
    if(frame == [sender mainFrame]) {
        [self.window setTitle:title];
    }
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
    if(frame == [sender mainFrame]) {
        [self.progress stopAnimation:self];
    }
}

- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame
{
    if(frame == [sender mainFrame]) {
        NSString* loadedURL = [[[[frame dataSource] request] URL] absoluteString];
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:[NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"Couldn't not %@", @""),loadedURL]];
        [alert runModal];
        
        [self.progress stopAnimation:self];
    }
}

-(IBAction)showTtitleBar:(NSMenuItem*)sender {
    if(sender.state == 0) {
        [self showTitleBarEnable];

    }
    else if(sender.state == 1) {
        [self showTitleBarDisable];
    }
    
}

-(void)showTitleBarEnable
{
    self.showTitleBarMenuItem.state = 1;
    [self.window setStyleMask:NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask];
}

-(void)showTitleBarDisable
{
    self.showTitleBarMenuItem.state = 0;
    [self.window setStyleMask:NSBorderlessWindowMask];
}


-(IBAction)ReloadPage:(id)sender
{
    [self.progress startAnimation:self];
    [[self.webview mainFrame] reload];
}
@end
