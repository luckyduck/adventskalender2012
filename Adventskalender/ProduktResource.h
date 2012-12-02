//
//  ProduktResource.h
//  Adventskalender
//
//  Created by Jan Brinkmann on 12/2/12.
//  Copyright (c) 2012 Jan Brinkmann. All rights reserved.
//

#import "AFNetworking.h"
#import <Foundation/Foundation.h>
#import "Produkt.h"

// error block - typedef for convenience
typedef void (^APIFailureBlock)(NSString *errorMessage);

// success block - typedef for convenience
typedef void (^ProduktSuccessBlock)(NSMutableArray *items);


@interface ProduktResource : AFHTTPClient

+ (ProduktResource*)sharedInstance;

- (void)fetchProducts:(ProduktSuccessBlock)success
              failure:(APIFailureBlock)failure;

@end
