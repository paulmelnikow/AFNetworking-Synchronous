AFNetworking-Synchronous
========================

A minimal category which extends [AFNetworking][] to support synchronous
requests.

[![Version](https://img.shields.io/cocoapods/v/AFNetworking-Synchronous.svg)](http://cocoapods.org/pods/AFNetworking-Synchronous)
[![License](https://img.shields.io/cocoapods/l/AFNetworking-Synchronous.svg?style=flat)](http://cocoapods.org/pods/AFNetworking-Synchronous)
[![Platform](https://img.shields.io/cocoapods/p/AFNetworking-Synchronous.svg?style=flat)](http://cocoapods.org/pods/AFNetworking-Synchronous)
[![Downloads](https://img.shields.io/cocoapods/dm/AFNetworking-Synchronous.svg)](http://cocoapods.org/pods/AFNetworking-Synchronous)
[![Build](https://img.shields.io/travis/paulmelnikow/AFNetworking-Synchronous.svg)](https://travis-ci.org/paulmelnikow/AFNetworking-Synchronous)

![It's synchronous](https://raw.githubusercontent.com/paulmelnikow/AFNetworking-Synchronous/assets/synchronized_diving.gif)


Usage
-----

### 3.x

```rb
  pod 'AFNetworking', '~> 3.0'
  pod 'AFNetworking-Synchronous/3.x'
```

```objective-c
#import <AFNetworking.h>
#import <AFHTTPSessionManager+Synchronous.h>

AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
NSError *error = nil;
NSData *result = [manager syncGET:@"/document/123"
                       parameters:paramDict
                             task:NULL
                            error:&error];
```

Your synchronous request will never return if it is dispatched on the session
manager's completion queue.

You really should not perform a synchronous network request on the main thread
on iOS, as it's likely to cause a crash when run outside the debugger. You
probably should not on OS X either, as it's likely to cause lags in the UI.

If you must do so, create a separate queue for the completion handlers:

```objective-c
manager.completionQueue = dispatch_queue_create("AFNetworking+Synchronous", NULL);
```

### 2.x

```rb
  pod 'AFNetworking', '~> 2.0'
  pod 'AFNetworking-Synchronous/2.x'
```

```objective-c
#import <AFNetworking.h>
#import <AFHTTPRequestOperationManager+Synchronous.h>

AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
NSError *error = nil;
NSData *result = [manager syncGET:@"/document/123"
                       parameters:paramDict
                        operation:NULL
                            error:&error];
```

Currently there is no support for AFHTTPSessionManager.

### 1.x

```rb
  pod 'AFNetworking', '~> 1.0'
  pod 'AFNetworking-Synchronous/1.x'
```

```objective-c
#import <AFNetworking.h>
#import <AFHTTPRequestOperationManager+Synchronous.h>

AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:...];
NSError *error = nil;
NSData *result = [client synchronouslyGetPath:@"/document/123"
                                   parameters:paramDict
                                    operation:NULL
                                        error:&error];
```


Discussion
----------

### First, consider adopting an asynchronous design

Before you decide to use this category, consider whether you can adopt an
asynchronous design instead. As @mattt wrote, asynchronism a tough thing to
get your head around, but it's well worth the mental overhead. Rather than
creating methods that fetch and return network data, use blocks or delegate
methods to call back with the results when you have them.

Using the asynchronous API has many advantages:

 - When you start an operation on the main thread, you return control to the
   run loop immediately, so your UI can remains responsive. Blocking the main
   thread for a long time is never a good idea. "Be responsive," Apple urges
   in the OS X user experience guidelines. Asynchronous network operations
   allow you to do that.
 - AFNetworking makes asynchronous code easy to write and easy to read. With
   block-based success and failure handlers, you don't need to implement
   delegate protocols or provide selectors for callbacks.
 - AFNetworking and Grand Central Dispatch take care of threading for you, so
   your code does not need to manage threads, run selectors in the background,
   or invoke dispatch_async. Your completion blocks will be executed on the
   main thread (unless you configure the operations otherwise).
 - You can provide a better user experience while waiting for a response.
   Networks are unreliable, particularly for mobile users, and servers can be
   bogged down. Your users' experiences will be better if you design for a slow
   connection, which you can only do asynchronously.

However, in some cases, a synchronous response is better, such as when the
document architecture or another framework is handling the multithreading for
you, and expects a synchronous result. This code attempts to provide a safe
and reliable way to use the framework synchronously.

While it overrides the default success and failure queues to avoid a deadlock,
it can't anticipate every possible situation. In particular, you should not
set the queue from which you're invoking as the processing queue, which will
cause a deadlock.

### The main thread

You shouldn't call these methods from the main thread. On iOS, if your
application enters the background while one of these methods is running on the
main thread, a deadlock may result and your application could be terminated.

### AFImageRequestOperation processingBlock and custom operation subclasses

This category is suitable for most of the request operation subclasses built
into AFNetworking, which process their response objects synchronously.

**If you're using the processingBlock on AFImageRequestOperation, which
contains essential processing in the completion handler, or your subclass
performs other asynchronous processing in the completion handler, use the
version in the [using-completion-blocks branch][using-completion-blocks].**

All custom subclasses must override `-responseObject`. See `AFHTTPRequestOperation+ResponseObject.h` for more information.


Development
-----------

This project includes integration tests which use the delightful service
[httpbin][]. To run them, run `pod install` inside the `TestProject` folder,
then load the workspace and execute the test action.

[httpbin]: https://httpbin.org/


Acknowledgements
----------------

- [EliSchleifer][] for AFNetworking 2.x support


License
-------

This project is licensed under the MIT license.


[EliSchleifer]: https://github.com/EliSchleifer
[AFNetworking]: https://github.com/AFNetworking/AFNetworking
[using-completion-blocks]: https://github.com/paulmelnikow/AFNetworking-Synchronous/tree/using-completion-blocks
