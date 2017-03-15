#import "AFHTTPRequestOperationManager+Synchronous.h"

@implementation AFHTTPRequestOperationManager (Synchronous)

- (id)synchronouslyPerformMethod:(NSString *)method
                       URLString:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                       operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
                           error:(NSError *__autoreleasing *)outError {

    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];

    AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request
                                                               success:nil
                                                               failure:nil];

    [op start];
    [op waitUntilFinished];

    if (operationPtr != nil) *operationPtr = op;

    // Must call responseObject before checking the error
    id responseObject = [op responseObject];
    if (outError != nil) *outError = [op error];

    return responseObject;
}

- (id)syncGET:(NSString *)URLString
   parameters:(NSDictionary *)parameters
    operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
        error:(NSError *__autoreleasing *)outError
{
    return [self synchronouslyPerformMethod:@"GET" URLString:URLString parameters:parameters operation:operationPtr error:outError];
}

- (id)syncPOST:(NSString *)URLString
    parameters:(NSDictionary *)parameters
     operation:(AFHTTPRequestOperation *__autoreleasing *) operationPtr
         error:(NSError *__autoreleasing *) outError
{
    return [self synchronouslyPerformMethod:@"POST" URLString:URLString parameters:parameters operation:operationPtr error:outError];
}

- (id)syncPUT:(NSString *)URLString
   parameters:(NSDictionary *)parameters
    operation:(AFHTTPRequestOperation *__autoreleasing *) operationPtr
        error:(NSError *__autoreleasing *) outError
{
    return [self synchronouslyPerformMethod:@"PUT" URLString:URLString parameters:parameters operation:operationPtr error:outError];
}

- (id)syncDELETE:(NSString *)URLString
      parameters:(NSDictionary *)parameters
       operation:(AFHTTPRequestOperation *__autoreleasing *) operationPtr
           error:(NSError *__autoreleasing *) outError
{
    return [self synchronouslyPerformMethod:@"DELETE" URLString:URLString parameters:parameters operation:operationPtr error:outError];
}

- (id)syncPATCH:(NSString *)URLString
     parameters:(NSDictionary *)parameters
      operation:(AFHTTPRequestOperation *__autoreleasing *) operationPtr
          error:(NSError *__autoreleasing *) outError
{
    return [self synchronouslyPerformMethod:@"PATCH" URLString:URLString parameters:parameters operation:operationPtr error:outError];
}

@end
