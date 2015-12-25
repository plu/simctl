# simctl

[![Build Status](https://travis-ci.org/plu/simctl.svg?branch=master)](https://travis-ci.org/plu/simctl) [![Gem Version](https://badge.fury.io/rb/simctl.svg)](https://badge.fury.io/rb/simctl)

Ruby interface to xcrun simctl.

## Installation

Via [bundler](http://getbundler.com)

```sh
# in your Gemfile
gem 'simctl'
```

## Usage

### boot_device

```ruby
device = SimCtl.device(name: 'my iphone 5', state: 'Shutdown')
SimCtl.boot_device(device)

# or:

SimCtl.device(name: 'my iphone 5', state: 'Shutdown').boot!
```

### create_device

```ruby
SimCtl.create_device 'my iphone 5', SimCtl.devicetype(name: 'iPhone 5'), SimCtl.runtime(name: 'iOS 9.2')

#<SimCtl::Device:0x007fbce48afd88 @state="Creating", @availability="(available)", @name="my iphone 5", @udid="6F7269E0-6375-4B72-8451-F2728BF6DA82", @os="iOS 9.2">
```

### delete_device

```ruby
device = SimCtl.device(name: 'my iphone 5', state: 'Booted')
SimCtl.delete_device(device)

# or:

SimCtl.device(name: 'my iphone 5', state: 'Booted').delete!
```

### devicetype

```ruby
SimCtl.devicetype(name: 'iPhone 5')

#<SimCtl::DeviceType:0x007fd90dd9f2e0 @name="iPhone 5", @identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-5">
```

### device

```ruby
SimCtl.device(name: 'my iphone 5', state: 'Booted')

#<SimCtl::Device:0x007fd90dcce910 @state="Booted", @availability="(available)", @name="my iphone 5", @udid="6F7269E0-6375-4B72-8451-F2728BF6DA82", @os="iOS 9.2">
```

### erase_device

```ruby
device = SimCtl.device(name: 'my iphone 5', state: 'Booted')
SimCtl.erase_device(device)

# or:

SimCtl.device(name: 'my iphone 5', state: 'Booted').erase!
```

### list_devices

```ruby
SimCtl.list_devices.each do |device|
  puts device.inspect
end

#<SimCtl::Device:0x007fd90dd06f90 @state="Booted", @availability="(available)", @name="iPhone 5", @udid="25AC234A-EB91-46EF-9BCB-B7405813EF93", @os="iOS 9.2">
#<SimCtl::Device:0x007fd90dd06e00 @state="Shutdown", @availability="(available)", @name="iPhone 5", @udid="CEFEDED6-94C0-4B6B-8ABC-B855C49F06B0", @os="iOS 9.2">
```

### list_devicetypes

```ruby
SimCtl.list_devicetypes.each do |devicetype|
  puts devicetype.inspect
end

#<SimCtl::DeviceType:0x007fbce48f5270 @name="iPhone 4s", @identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-4s">
#<SimCtl::DeviceType:0x007fbce48f51f8 @name="iPhone 5", @identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-5">
#<SimCtl::DeviceType:0x007fbce48f5180 @name="iPhone 5s", @identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-5s">
#<SimCtl::DeviceType:0x007fbce48f5108 @name="iPhone 6", @identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-6">
#<SimCtl::DeviceType:0x007fbce48f5090 @name="iPhone 6 Plus", @identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-6-Plus">
#<SimCtl::DeviceType:0x007fbce48f5018 @name="iPhone 6s", @identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-6s">
#<SimCtl::DeviceType:0x007fbce48f4fa0 @name="iPhone 6s Plus", @identifier="com.apple.CoreSimulator.SimDeviceType.iPhone-6s-Plus">
#<SimCtl::DeviceType:0x007fbce48f4f28 @name="iPad 2", @identifier="com.apple.CoreSimulator.SimDeviceType.iPad-2">
#<SimCtl::DeviceType:0x007fbce48f4eb0 @name="iPad Retina", @identifier="com.apple.CoreSimulator.SimDeviceType.iPad-Retina">
#<SimCtl::DeviceType:0x007fbce48f4e38 @name="iPad Air", @identifier="com.apple.CoreSimulator.SimDeviceType.iPad-Air">
#<SimCtl::DeviceType:0x007fbce48f4dc0 @name="iPad Air 2", @identifier="com.apple.CoreSimulator.SimDeviceType.iPad-Air-2">
#<SimCtl::DeviceType:0x007fbce48f4d48 @name="iPad Pro", @identifier="com.apple.CoreSimulator.SimDeviceType.iPad-Pro">
#<SimCtl::DeviceType:0x007fbce48f4cd0 @name="Apple TV 1080p", @identifier="com.apple.CoreSimulator.SimDeviceType.Apple-TV-1080p">
#<SimCtl::DeviceType:0x007fbce48f4c58 @name="Apple Watch - 38mm", @identifier="com.apple.CoreSimulator.SimDeviceType.Apple-Watch-38mm">
#<SimCtl::DeviceType:0x007fbce48f4be0 @name="Apple Watch - 42mm", @identifier="com.apple.CoreSimulator.SimDeviceType.Apple-Watch-42mm">
```

### list_runtimes

```ruby
SimCtl.list_runtimes.each do |runtime|
  puts runtime.inspect
end

#<SimCtl::Runtime:0x007fbce48cd6d0 @buildversion="12B411", @availability="(available)", @name="iOS 8.1", @identifier="com.apple.CoreSimulator.SimRuntime.iOS-8-1", @version="8.1">
#<SimCtl::Runtime:0x007fbce48cd5e0 @buildversion="12D508", @availability="(available)", @name="iOS 8.2", @identifier="com.apple.CoreSimulator.SimRuntime.iOS-8-2", @version="8.2">
#<SimCtl::Runtime:0x007fbce48cd4f0 @buildversion="12F70", @availability="(available)", @name="iOS 8.3", @identifier="com.apple.CoreSimulator.SimRuntime.iOS-8-3", @version="8.3">
#<SimCtl::Runtime:0x007fbce48cd400 @buildversion="12H141", @availability="(available)", @name="iOS 8.4", @identifier="com.apple.CoreSimulator.SimRuntime.iOS-8-4", @version="8.4">
#<SimCtl::Runtime:0x007fbce48cd310 @buildversion="13A344", @availability="(available)", @name="iOS 9.0", @identifier="com.apple.CoreSimulator.SimRuntime.iOS-9-0", @version="9.0">
#<SimCtl::Runtime:0x007fbce48cd220 @buildversion="13C75", @availability="(available)", @name="iOS 9.2", @identifier="com.apple.CoreSimulator.SimRuntime.iOS-9-2", @version="9.2">
#<SimCtl::Runtime:0x007fbce48cd130 @buildversion="13U78", @availability="(available)", @name="tvOS 9.1", @identifier="com.apple.CoreSimulator.SimRuntime.tvOS-9-1", @version="9.1">
#<SimCtl::Runtime:0x007fbce48cd040 @buildversion="13S660", @availability="(available)", @name="watchOS 2.1", @identifier="com.apple.CoreSimulator.SimRuntime.watchOS-2-1", @version="2.1">
```

### runtime

```ruby
SimCtl.runtime(name: 'iOS 9.2')

#<SimCtl::Runtime:0x007fd90dd2da28 @buildversion="13C75", @availability="(available)", @name="iOS 9.2", @identifier="com.apple.CoreSimulator.SimRuntime.iOS-9-2", @version="9.2">
```

### shutdown_device

```ruby
device = SimCtl.device(name: 'my iphone 5', state: 'Booted')
SimCtl.shutdown_device(device)

# or:

SimCtl.device(name: 'my iphone 5', state: 'Booted').shutdown!
```
