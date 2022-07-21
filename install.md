# Install Guide

The process for installing the Flutter NRI Agent is a little invloved, but the steps will tried to be outlined as well as possible here.

## Intall the agents

You will need to install the agents individually in your projects in order for Flutter to be able to scrape the lower level system information like memory usage.

For iOS, follow this guide: [New Relic iOS Install Guide](https://docs.newrelic.com/docs/mobile-monitoring/new-relic-mobile-ios/installation/ios-manual-installation/)

For Android, this one: [New Relic Android Install Guide](https://docs.newrelic.com/docs/mobile-monitoring/new-relic-mobile-android/install-configure/install-android-apps-gradle-android-studio/)

> Note: For Android, some additional code needs to be added when working with Flutter.

Inside of your `android/app/src/main/kotlin/.../MainActivity.kt` file, you will need to add a method overriding the `onCreate` method.

```kotlin
import android.os.Bundle
// ... more imports

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        NewRelic.withApplicationToken(" YOUR APP TOKEN HERE ").start(this.applicationContext)
        super.onCreate(savedInstanceState)
    }
    // ... other options
}
```

## Create a Method channel

You will use a method channel to access the integration agents through flutter. A good example on how to create method channels can be found on [docs.flutter.dev](https://docs.flutter.dev/development/platform-integration/platform-channels?tab=android-channel-kotlin-tab).

Specific interactions with the agent can be found inside of this project. Make sure you add your application token on ios and android before launching the project.

## Run the app

## Authors

- Jake Landers
- Kartik Pattaswamy
- Hitesh Ahuja

