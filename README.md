# simctl

[![Build Status](https://travis-ci.org/plu/simctl.svg?branch=master)](https://travis-ci.org/plu/simctl)

Ruby interface to xcrun simctl.

## Installation

Via [bundler](http://getbundler.com)

```sh
# in your Gemfile
gem 'simctl'
```

## Usage

### list_runtimes

```ruby
SimCtl.list_runtimes.each do |runtime|
  puts runtime
end
```

```
#<SimCtl::Runtime buildversion="12B411", availability="(available)", name="iOS 8.1", identifier="com.apple.CoreSimulator.SimRuntime.iOS-8-1", version="8.1">
#<SimCtl::Runtime buildversion="12D508", availability="(available)", name="iOS 8.2", identifier="com.apple.CoreSimulator.SimRuntime.iOS-8-2", version="8.2">
#<SimCtl::Runtime buildversion="12F70", availability="(available)", name="iOS 8.3", identifier="com.apple.CoreSimulator.SimRuntime.iOS-8-3", version="8.3">
#<SimCtl::Runtime buildversion="12H141", availability="(available)", name="iOS 8.4", identifier="com.apple.CoreSimulator.SimRuntime.iOS-8-4", version="8.4">
#<SimCtl::Runtime buildversion="13A344", availability="(available)", name="iOS 9.0", identifier="com.apple.CoreSimulator.SimRuntime.iOS-9-0", version="9.0">
#<SimCtl::Runtime buildversion="13C75", availability="(available)", name="iOS 9.2", identifier="com.apple.CoreSimulator.SimRuntime.iOS-9-2", version="9.2">
#<SimCtl::Runtime buildversion="13U78", availability="(available)", name="tvOS 9.1", identifier="com.apple.CoreSimulator.SimRuntime.tvOS-9-1", version="9.1">
#<SimCtl::Runtime buildversion="13S660", availability="(available)", name="watchOS 2.1", identifier="com.apple.CoreSimulator.SimRuntime.watchOS-2-1", version="2.1">
```

### list_devicetypes

```ruby
SimCtl.list_devicetypes.each do |devicetype|
  puts devicetype
end
```

```
#<SimCtl::DeviceType name="iPhone 4s", identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-4s">
#<SimCtl::DeviceType name="iPhone 5", identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-5">
#<SimCtl::DeviceType name="iPhone 5s", identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-5s">
#<SimCtl::DeviceType name="iPhone 6", identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-6">
#<SimCtl::DeviceType name="iPhone 6 Plus", identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-6-Plus">
#<SimCtl::DeviceType name="iPhone 6s", identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-6s">
#<SimCtl::DeviceType name="iPhone 6s Plus", identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-6s-Plus">
#<SimCtl::DeviceType name="iPad 2", identifier="com.apple.CoreSimulator.SimDeviceType.iPad-2">
#<SimCtl::DeviceType name="iPad Retina", identifier="com.apple.CoreSimulator.SimDeviceType.iPad-Retina">
#<SimCtl::DeviceType name="iPad Air", identifier="com.apple.CoreSimulator.SimDeviceType.iPad-Air">
#<SimCtl::DeviceType name="iPad Air 2", identifier="com.apple.CoreSimulator.SimDeviceType.iPad-Air-2">
#<SimCtl::DeviceType name="iPad Pro", identifier="com.apple.CoreSimulator.SimDeviceType.iPad-Pro">
#<SimCtl::DeviceType name="Apple TV 1080p", identifier="com.apple.CoreSimulator.SimDeviceType.Apple-TV-1080p">
#<SimCtl::DeviceType name="Apple Watch - 38mm", identifier="com.apple.CoreSimulator.SimDeviceType.Apple-Watch-38mm">
#<SimCtl::DeviceType name="Apple Watch - 42mm", identifier="com.apple.CoreSimulator.SimDeviceType.Apple-Watch-42mm">
```
