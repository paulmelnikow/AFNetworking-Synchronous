#import "AFHTTPRequestOperationManager.h"

/**
 A minimal category which extends AFHTTPRequestOperationManager to support
 synchronous requests.
*/
@interface AFHTTPRequestOperationManager (Synchronous)

/**
 Creates and runs an AFHTTPRequestOperation with a GET request.

 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client
   request serializer.
 @param operationPtr The address at which a pointer to the
    AFHTTPRequestOperation is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The response object created by the client response serializer.
 */
- (id)syncGET:(NSString *)URLString
   parameters:(NSDictionary *)parameters
    operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
        error:(NSError *__autoreleasing *)outError;

/**
 Creates and runs an AFHTTPRequestOperation with a POST request.

 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client
    request serializer.
 @param operationPtr The address at which a pointer to the
    AFHTTPRequestOperation is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The response object created by the client response serializer.
 */
- (id)syncPOST:(NSString *)URLString
    parameters:(NSDictionary *)parameters
     operation:(AFHTTPRequestOperation *__autoreleasing *) operationPtr
         error:(NSError *__autoreleasing *) outError;

/**
 Creates and runs an AFHTTPRequestOperation with a PUT request.

 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client
    request serializer.
 @param operationPtr The address at which a pointer to the
    AFHTTPRequestOperation is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The response object created by the client response serializer.
 */
- (id)syncPUT:(NSString *)URLString
   parameters:(NSDictionary *)parameters
    operation:(AFHTTPRequestOperation *__autoreleasing *) operationPtr
        error:(NSError *__autoreleasing *) outError;
/**
 Creates and runs an AFHTTPRequestOperation with a DELETE request.

 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client
    request serializer.
 @param operationPtr The address at which a pointer to the
    AFHTTPRequestOperation is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The response object created by the client response serializer.
 */
- (id)syncDELETE:(NSString *)URLString
      parameters:(NSDictionary *)parameters
       operation:(AFHTTPRequestOperation *__autoreleasing *) operationPtr
           error:(NSError *__autoreleasing *) outError;

/**
 Creates and runs an AFHTTPRequestOperation with a PATCH request.

 @param URLString The URL string used to create the request URL.
 @param parameters The parameters to be encoded according to the client
    request serializer.
 @param operationPtr The address at which a pointer to the
    AFHTTPRequestOperation is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The response object created by the client response serializer.
 */
- (id)syncPATCH:(NSString *)URLString
     parameters:(NSDictionary *)parameters
      operation:(AFHTTPRequestOperation *__autoreleasing *) operationPtr
          error:(NSError *__autoreleasing *) outError;

/**
 Enqueue an AFHTTPRequestOperation with a request for the given HTTP method.

 @param method The HTTP method.
 @param path The path to be appended to the HTTP client's base URL and used as the
    request URL.
 @param parameters The parameters to be encoded and set in the request HTTP body.
 @param operationPtr The address at which a pointer to the
    AFHTTPRequestOperation is placed.
 @param outError The address at which a pointer to an error object is placed
    when the request operation finishes unsucessfully.

 @return The object created from the response data of the request.
 */
- (id)synchronouslyPerformMethod:(NSString *)method
                       URLString:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                       operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
                           error:(NSError *__autoreleasing *)outError;

@end
