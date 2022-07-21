# Integrating New Relic with a Flutter Application

This project uses New Relic's iOS and Android agents to provide observability into a Flutter application. Currently New Relic supports agents for single OS applications such as iOS/Android. As Flutter/other cross platform frameworks grow in popularity, it's necessary for New Relic's observability options to expand as well. 

## Getting Started

Checkout `install.md` for how to integrate this project on your New Relic account

## Repository Layout
The strucutre of the demo app used to communicate with New Relic's database can be found in ```lib/main.dart```. This file renders buttons to simulate each type of the following method calls. A button clicked will trigger a method in the respective OS's native code.

Several post-request like methods were implemented natively in both iOS and Android in the flutter application to send data to the New Relic One database.


  ```sendStringValue()```: Sends a String\
  ```sendDoubleValue()```: Sends a Double\
  ```sendBoolValue()```: Sends a Boolean\
  ```incrementValue()```: Increments a value (Double)\
  ```sendCustomValue()```: Sends a Custom Value\
  ```recordException()```: Sends an exception that has been caught

Each method returns a boolean indicating whether a New Relic API call designed to set an attribute was performed successfully. 

## Dashboards
The JSON file for the dashboard to be imported can be found in ```dashboard.json```

The metrics displayed in the dashboard include: ```Average Session Duration, Button Clicks, Average/Max Memory Usage, Exceptions, Network Latency and Crashes```. 
Metrics are collected on both iOS and Android and both OS's data can be visualized on the same panel to compare/contrast application performance. 

<img width="1705" alt="Flutter Dashboard" src="https://github.com/jake-landersweb/flutter-nri-agent/blob/main/dashboard_flutter01.png">

