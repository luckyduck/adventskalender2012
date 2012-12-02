//
//  Produkt.h
//  Adventskalender
//
//  Created by Jan Brinkmann on 12/1/12.
//  Copyright (c) 2012 Jan Brinkmann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Produkt : NSObject

// 1
@property (strong, nonatomic) NSString *produktName;

// 2
- (id)initWithAttributes:(NSDictionary *)attributes;

@end
