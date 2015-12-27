require 'securerandom'
require 'test_helper'
require 'timeout'

class SimCtl::Command::CRUDTest < Minitest::Test
  def setup
    @devicetype = SimCtl.list_devicetypes.select {|devicetype| devicetype.name =~ %r[iPhone]}.first
    @runtime = SimCtl.list_runtimes.select {|runtime| runtime.name =~ %r[iOS.*9]}.first
    @device = SimCtl.create_device SecureRandom.hex, @devicetype, @runtime
    wait_for {|device| device.state != 'Creating'}
  end

  def teardown
    device = SimCtl.device(udid: @device.udid)
    return unless device
    device.shutdown! if device.state != 'Shutdown'
    device.delete!
  end

  def wait_for
    Timeout::timeout(30) do
      loop do
        device = SimCtl.device(udid: @device.udid)
        break if yield device
      end
    end
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

  should 'erase the device created in setup' do
    device = SimCtl.device(udid: @device.udid)
    SimCtl.erase_device device
  end

  should 'boot/shutdown the device created in setup' do
    device = SimCtl.device(udid: @device.udid)
    SimCtl.boot_device device
    wait_for {|device| device.state == 'Booted'}
    SimCtl.shutdown_device device
    wait_for {|device| device.state == 'Shutdown'}
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
    wait_for {|device| device.state != 'Creating'}
  end
end
