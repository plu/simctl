require 'securerandom'
require 'test_helper'

class SimCtl::Command::CRUDTest < Minitest::Test
  order_dependent!

  udid = nil
  name = SecureRandom.hex
  devicetype = 'iPhone 5'

  should 'raise exception if devicetype lookup failed' do
    assert_raises { SimCtl.create_device SecureRandom.hex, 'invalid devicetype', SimCtl::Runtime.latest(:ios) }
  end

  should 'raise exception if runtime lookup failed' do
    assert_raises { SimCtl.create_device name, SimCtl::DeviceType.find(name: devicetype), 'invalid runtime' }
  end

  should '0100. create a new device' do
    device = SimCtl.create_device name, devicetype, SimCtl::Runtime.latest(:ios)
    device.wait! {|d| d.state == :shutdown}
    udid = device.udid
  end

  should '0200. find the device by udid' do
    device = SimCtl.device(udid: udid)
    assert_kind_of SimCtl::Device, device
    assert device.availability != nil
    assert device.name == name
    assert device.os != nil
    assert device.state != nil
    assert device.udid != nil
  end

  should '0300. find the device by name' do
    assert SimCtl.device(name: name).udid == udid
    assert SimCtl.device(name: name) == SimCtl.device(udid: udid)
  end

  should '0400. have devicetype property' do
    assert SimCtl.device(udid: udid).devicetype == SimCtl.devicetype(name: devicetype)
  end

  should '0500. have runtime property' do
    assert SimCtl.device(udid: udid).runtime == SimCtl::Runtime.latest(:ios)
  end

  should '0600. rename the device' do
    SimCtl.device(udid: udid).rename!('new name')
    assert SimCtl.device(udid: udid).name == 'new name'
  end

  should '0700. erase the device' do
    SimCtl.device(udid: udid).erase!
  end

  should '0800. launch the device' do
    device = SimCtl.device(udid: udid)
    device.launch!
    device.wait!{|d| d.state == :booted}
  end

  should '0810. launch safari' do
    device = SimCtl.device(udid: udid)
    device.launch_app!('com.apple.mobilesafari')
  end

  should '0820. install SampleApp' do
    system 'cd test/SampleApp && xcodebuild -sdk iphonesimulator >/dev/null 2>&1'
    device = SimCtl.device(udid: udid)
    device.install!('test/SampleApp/build/Release-iphonesimulator/SampleApp.app')
  end

  should '0830. launch SampleApp' do
    system 'cd test/SampleApp && xcodebuild -sdk iphonesimulator >/dev/null 2>&1'
    device = SimCtl.device(udid: udid)
    device.launch_app!('com.github.plu.simctl.SampleApp')
  end

  should '0900. kill the device' do
    device = SimCtl.device(udid: udid)
    assert device.kill!
    device.wait!{|d| d.state == :shutdown}
  end

  should '1000. boot the device' do
    device = SimCtl.device(udid: udid)
    device.boot!
    device.wait!{|d| d.state == :booted}
  end

  should '1100. shutdown the device' do
    device = SimCtl.device(udid: udid)
    device.shutdown!
    device.wait!{|d| d.state == :shutdown}
  end

  should '1200. disable keyboard helpers' do
    device = SimCtl.device(udid: udid)
    device.settings.disable_keyboard_helpers!
    assert File.exists?(device.path.preferences_plist)
  end

  should '9800. reset the device' do
    old_device = SimCtl.device(udid: udid)
    new_device = old_device.reset!
    new_device.wait!{|d| d.state != :creating}
    new_device.wait!{|d| File.exists?(d.path.device_plist)}
    assert old_device.name == new_device.name
    assert old_device.devicetype == new_device.devicetype
    assert old_device.runtime == new_device.runtime
    assert old_device.udid != new_device.udid
    udid = new_device.udid
  end

  should '9900. delete the device' do
    device = SimCtl.device(udid: udid)
    device.delete!
    assert_nil SimCtl.device(udid: udid)
  end
end
