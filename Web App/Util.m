//
//  Util.m
//  webapp
//
//  Created by Htain Lin Shwe on 5/11/12.
//  Copyright (c) 2012 comquas. All rights reserved.
//

#import "Util.h"

#define trimAll( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

@implementation Util

+ (BOOL)isEmpty:(NSString *)string {
    return ([trimAll(string) length] == 0) ? YES:NO;
}



@end
