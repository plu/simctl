require 'securerandom'
require 'test_helper'

class SimCtl::Command::CRUDTest < Minitest::Test
  def setup
    @devicetype = SimCtl.list_devicetypes.select {|devicetype| devicetype.name =~ %r[iPhone]}.first
    @runtime = SimCtl.list_runtimes.select {|runtime| runtime.name =~ %r[iOS.*9]}.first
    @device = SimCtl.create_device SecureRandom.hex, @devicetype, @runtime
    @device.wait! {|device| device.state != :creating}
  end

  def teardown
    device = SimCtl.device(udid: @device.udid)
    return unless device
    device.kill!
    device.shutdown! if device.state != :shutdown
    device.wait! {|d| d.state == :shutdown}
    device.delete!
  end

  should 'find the device created in setup' do
    device = SimCtl.device(udid: @device.udid)
    assert_kind_of SimCtl::Device, device
    assert device.availability != nil
    assert device.name != nil
    assert device.os != nil
    assert device.state != nil
    assert device.udid != nil
  end

  should 'launch and kill the device created in setup' do
    device = SimCtl.device(udid: @device.udid)
    assert device.launch!
    device.wait!{|device| device.state == :booted}
    assert device.kill!
  end

  should 'erase the device created in setup' do
    device = SimCtl.device(udid: @device.udid)
    device.erase!
  end

  should 'boot/shutdown the device created in setup' do
    device = SimCtl.device(udid: @device.udid)
    SimCtl.boot_device device
    device.wait! {|device| device.state == :booted}
    SimCtl.shutdown_device device
    device.wait! {|device| device.state == :shutdown}
  end

  should 'delete the device created in setup' do
    device = SimCtl.device(udid: @device.udid)
    SimCtl.delete_device device
    assert_nil SimCtl.device(udid: @device.udid)
  end

  should 'reset the device created in setup' do
    device = SimCtl.reset_device @device.name, @devicetype, @runtime
    assert_kind_of SimCtl::Device, device
    assert_nil SimCtl.device(udid: @device.udid)
    @device = device # teardown cleanup
    device.wait! {|device| device.state != :creating}
  end
end
