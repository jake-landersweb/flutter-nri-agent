# Install Guide

The process for installing the Flutter NRI Agent is a little invloved, but the steps will tried to be outlined as well as possible here.

## Install the agents

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

Build the application and make sure metrics are being reported on your New Relic dashboard.

## Edit the dashboard

Using the sample dashboard, you can change some of the NRQL queries to fit your application's metadata. Don't be intimidated, these changes are minor!

On the dashboard, you can click the three dots in the corner of the cells. Click on `edit`. Then anywhere you see the attribute `entityGuid`, change it to your apps guid depending if it is android or ios. Then, anywhere you see `appName`, change it to the name you gave your android / ios app name inside of New Relic. 

## Adding New Metrics to the Dashboard

If there are other things you want to test out that you can track, send a custom Event to New Relic with the type of `Flutter`. This is how we drive the `Button Clicks` and `Exceptions` dashboard panels.

> Note: For GUID, if you remove the value, New Relic will try to auto-complete to use your personal value.

## Authors

- Jake Landers
- Kartik Pattaswamy
- Hitesh Ahuja

