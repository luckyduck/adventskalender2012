//
//  ProduktResource.m
//  Adventskalender
//
//  Created by Jan Brinkmann on 12/2/12.
//  Copyright (c) 2012 Jan Brinkmann. All rights reserved.
//

#import "ProduktResource.h"

#define kAPIHost @"http://shop.the-luckyduck.de/api/rest/"

@implementation ProduktResource


#pragma mark - 
#pragma mark all about creating instances

// singleton
+ (ProduktResource*)sharedInstance
{
    static ProduktResource *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:kAPIHost]];
    });
    
    [sharedInstance setDefaultHeader:@"Accept" value:@"application/json"];
    
    return sharedInstance;
}

// create instance with given base url
- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    
    return self;
}



#pragma mark -
#pragma mark error handling
- (NSString *)errorMessageForResponse:(AFHTTPRequestOperation *)operation error:(NSError *)error
{
    if ([operation.responseString length] > 0) {
        NSData *jsonData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:0
                                                               error:nil];
        
        return [[[[json objectForKey:@"messages"] objectForKey:@"error"] objectAtIndex:0] objectForKey:@"message"];
                
    } else {
        return [error localizedDescription];
    }
    
}

- (void)processFailureBlock:(APIFailureBlock)failure
                  operation:(AFHTTPRequestOperation *)operation
                      error:(NSError *)error
{   
    // internal server error handling
    if (operation.response.statusCode == 500 || operation.response.statusCode == 404) {
        failure(@"Server returned an error.");
        
    } else {
        // get error message from response
        NSString *errorMessage = [self errorMessageForResponse:operation error:error];
        failure(errorMessage);
    }
}


#pragma mark -
#pragma mark API related 
- (void)fetchProducts:(ProduktSuccessBlock)success failure:(APIFailureBlock)failure
{
    [[[self class] sharedInstance] getPath:@"products"
                       parameters:nil
                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                              NSMutableArray *produkte = [[NSMutableArray alloc] init];
                              
                              for (id key in responseObject) {
                                  NSDictionary *attributes = [responseObject objectForKey:key];
                                  Produkt *produkt = [[Produkt alloc] initWithAttributes:attributes];
                                  [produkte addObject:produkt];
                              }
                              
                              success(produkte);
                          }
                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                              [self processFailureBlock:failure operation:operation error:error];
                          }];
}



@end
