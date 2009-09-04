//
//  GGSnowLeopardFormattingFixPlugin.m
//  Snow Leopard Formatting Fix
//
//  Created by Gabriel Gironda on 9/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GGSnowLeopardFormattingFixPlugin.h"
#import <Adium/AIAdiumProtocol.h>
#import <Adium/AIContentControllerProtocol.h>
#import <Adium/AIContentMessage.h>
#import <Adium/AIMenuControllerProtocol.h>
#import <Adium/AIPreferenceControllerProtocol.h>
#import <AIUtilities/AIMenuAdditions.h>
#import <AIUtilities/AIAttributedStringAdditions.h>
#import <AIUtilities/AIDictionaryAdditions.h>
#import <AIUtilities/AIStringUtilities.h>

@implementation GGSnowLeopardFormattingFixPlugin

- (NSString *)pluginAuthor {
	return @"Gabriel Gironda";
}
- (NSString *)pluginURL {
    return @"http://www.gironda.org";
}
- (NSString *)pluginVersion {
	return @"0.0.1";
}
- (NSString *)pluginDescription {
	return @"Snow Leopard somehow made all my outgoing AIM messages have a white background. Fuck Snow Leopard.";
}

- (void)installPlugin {
	NSLog(@"GGSnowLeopardFormattingFixPlugin loaded!");
	[[adium contentController] registerContentFilter:self 
											  ofType:AIFilterContent 
										   direction:AIFilterOutgoing];
	
	enableFormattingFix = [[[adium preferenceController] preferenceForKey:@"enableFormattingFix" 
																	group:@"GGSnowLeopardFormattingFix"] boolValue];
	
	toggleFormattingFixMI = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:@"Strip BG color from outgoing messages" 
																			  target:self
																			  action:@selector(toggleFormattingFix:) 
																	   keyEquivalent:@""];
	if (enableFormattingFix) {
		[toggleFormattingFixMI setState:NSOnState];
	} else {
		[toggleFormattingFixMI setState:NSOffState];
	}
	
	[[adium menuController] addMenuItem:toggleFormattingFixMI toLocation:LOC_Format_Additions];
}

- (void)uninstallPlugin {	
	[toggleFormattingFixMI release];
	[[adium contentController] unregisterContentFilter:self];
}

- (NSAttributedString *)filterAttributedString:(NSAttributedString *)inAttributedString context:(id)context;
{
	if (enableFormattingFix && inAttributedString && [inAttributedString length] && [context isKindOfClass:[AIContentMessage class]]) {
		NSLog(@"Removing BG attribute from message");
		NSMutableAttributedString *ourAttributedString = [[inAttributedString mutableCopy] autorelease];
		[ourAttributedString removeAttribute: @"NSBackgroundColor" range: NSMakeRange(0, [inAttributedString length])];
		
		return ourAttributedString;
	}
	
	return inAttributedString;
}

- (void)toggleFormattingFix:(id)sender {
	enableFormattingFix = enableFormattingFix ? NO : YES;
	
	[[adium preferenceController] setPreference:[NSNumber numberWithBool:enableFormattingFix]
										 forKey:@"enableFormattingFix" 
										  group:@"GGSnowLeopardFormattingFix"];
	
	if (enableFormattingFix) {
		[toggleFormattingFixMI setState:NSOnState];
	} else {
		[toggleFormattingFixMI setState:NSOnState];
	}
}

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem {
	return YES;
}

- (float)filterPriority {
	return HIGHEST_FILTER_PRIORITY;
}

@end
