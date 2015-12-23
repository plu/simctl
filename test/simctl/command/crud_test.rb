require 'securerandom'
require 'test_helper'
require 'timeout'

class SimCtl::Command::CRUDTest < Minitest::Test
  def setup
    @devicetype = SimCtl.list_devicetypes.select {|devicetype| devicetype.name =~ %r[iPhone]}.first
    @runtime = SimCtl.list_runtimes.select {|runtime| runtime.name =~ %r[iOS.*9]}.first
    @device = SimCtl.create_device SecureRandom.hex, @devicetype, @runtime
    Timeout::timeout(15) do
      loop do
        device = SimCtl.device(udid: @device.udid)
        break if device && device.state != 'Creating'
      end
    end
  end

  def teardown
    device = SimCtl.device(udid: @device.udid)
    SimCtl.delete_device device if device
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

  should 'delete the device created in setup' do
    device = SimCtl.device(udid: @device.udid)
    SimCtl.delete_device device
    assert_nil SimCtl.device(udid: @device.udid)
  end
end
