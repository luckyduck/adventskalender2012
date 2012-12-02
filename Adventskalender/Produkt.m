//
//  Produkt.m
//  Adventskalender
//
//  Created by Jan Brinkmann on 12/2/12.
//  Copyright (c) 2012 Jan Brinkmann. All rights reserved.
//

#import "Produkt.h"

@implementation Produkt

- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    NSLog(@"%@", [attributes description]);
    
    self.produktName = [attributes valueForKeyPath:@"name"];

    return self;
}

@end
