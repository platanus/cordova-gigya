Cordova Gigya
================

[Cordova](http://cordova.apache.org/) plugin that handles Gigya integration for mobile (iOS and Android) apps.

Project uses mobile native Gigya SDK for iOS and Androidplat to utilize basic operations for a mobile app that uses Cordova. 

## Prerequisites

### iOS
In iOS is mandatory to use the native Facebook integration, for that we need to use the FacebookSDK.

Download the latest [FacebookSDK](https://developers.facebook.com/docs/ios/), and follow the [getting started guideline](https://developers.facebook.com/docs/ios/getting-started/). 

## Installing the plugin
To add this plugin just type:
```
cordova plugin add https://github.com/platanus/cordova-gigya
```

## To remove this plugin type:
```
cordova plugin remove us.platan.gigya
```

##Usage

The plugin has the following methods:

* [initialize](#initialize)
* [showLoginUI](#showLoginUI)
* [logout](#logout)
* [getUserInfo](#getUserInfo)
* [getSession](#getSession)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/platanus/cordova-gigya/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

cordova-gigya is maintained by [platanus](http://platan.us).

## License

Apache License Version 2.0.
