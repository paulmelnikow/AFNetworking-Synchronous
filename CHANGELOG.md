# AFNetworking-Synchronous Release History

## v1.0.0
March 14, 2017

The API is identical to 0.3.x, which has been stable for some time.

Clean up documentation.


## v0.3.1
February 24, 2015

Fix issue in 2.x where method is always GET.


## v0.3.0
December 26, 2014

Add support for AFNetworking 2.x.

BREAKING CHANGE:

Synchronous support for 1.x and 2.x are implemented in two [subspecs][].
In your Podfile, you must specify the one you need.

```rb
  pod 'AFNetworking', '~> 1.0'
  pod 'AFNetworking-Synchronous/1.x'
```

```rb
  pod 'AFNetworking', '~> 2.0'
  pod 'AFNetworking-Synchronous/2.x'
```

Thanks [@EliSchleifer][] for contributing this functionality.


## v0.2.0
November 5, 2013

Return `-responseData` for instances of `AFHTTPRequestOperation`.


## v0.1.0
September 29, 2013

Initial release, Cocoapods support.


[subspecs]: http://guides.cocoapods.org/syntax/podspec.html#subspec
[@EliSchleifer]: https://github.com/EliSchleifer
