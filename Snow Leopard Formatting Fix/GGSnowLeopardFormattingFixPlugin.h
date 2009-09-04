//
//  GGSnowLeopardFormattingFixPlugin.h
//  Snow Leopard Formatting Fix
//
//  Created by Gabriel Gironda on 9/4/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Adium/AIPlugin.h>
#import <Adium/AISharedAdium.h>
#import <Cocoa/Cocoa.h>

@protocol AIContentFilter;

@interface GGSnowLeopardFormattingFixPlugin : AIPlugin <AIContentFilter> {
	NSMenuItem			*toggleFormattingFixMI;
	BOOL				enableFormattingFix;
}

@end
