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

  should '01. create a new device' do
    device = SimCtl.create_device name, devicetype, SimCtl::Runtime.latest(:ios)
    device.wait! {|d| d.state == :shutdown}
    udid = device.udid
  end

  should '02. find the device by udid' do
    device = SimCtl.device(udid: udid)
    assert_kind_of SimCtl::Device, device
    assert device.availability != nil
    assert device.name == name
    assert device.os != nil
    assert device.state != nil
    assert device.udid != nil
  end

  should '03. find the device by name' do
    assert SimCtl.device(name: name).udid == udid
    assert SimCtl.device(name: name) == SimCtl.device(udid: udid)
  end

  should '04. have devicetype property' do
    assert SimCtl.device(udid: udid).devicetype == SimCtl.devicetype(name: devicetype)
  end

  should '05. have runtime property' do
    assert SimCtl.device(udid: udid).runtime == SimCtl::Runtime.latest(:ios)
  end

  should '06. rename the device' do
    SimCtl.device(udid: udid).rename!('new name')
    assert SimCtl.device(udid: udid).name == 'new name'
  end

  should '07. erase the device' do
    SimCtl.device(udid: udid).erase!
  end

  should '08. launch the device' do
    device = SimCtl.device(udid: udid)
    device.launch!
    device.wait!{|d| d.state == :booted}
  end

  should '09. kill the device' do
    device = SimCtl.device(udid: udid)
    assert device.kill!
    device.wait!{|d| d.state == :shutdown}
  end

  should '10. boot the device' do
    device = SimCtl.device(udid: udid)
    device.boot!
    device.wait!{|d| d.state == :booted}
  end

  should '11. shutdown the device' do
    device = SimCtl.device(udid: udid)
    device.shutdown!
    device.wait!{|d| d.state == :shutdown}
  end

  should '12. disable keyboard helpers' do
    device = SimCtl.device(udid: udid)
    device.disable_keyboard_helpers!
    assert File.exists?(device.path.preferences_plist)
  end

  should '98. reset the device' do
    old_device = SimCtl.device(udid: udid)
    new_device = old_device.reset!
    new_device.wait!{|d| d.state != :creating}
    assert old_device.name == new_device.name
    assert old_device.devicetype == new_device.devicetype
    assert old_device.runtime == new_device.runtime
    assert old_device.udid != new_device.udid
    udid = new_device.udid
  end

  should '99. delete the device' do
    device = SimCtl.device(udid: udid)
    device.delete!
    assert_nil SimCtl.device(udid: udid)
  end
end
