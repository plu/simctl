require 'test_helper'

class SimCtl::Command::ListTest < Minitest::Test
  context 'devicetype' do
    should 'find device type by name' do
      assert_kind_of SimCtl::DeviceType, SimCtl.devicetype(name: 'iPhone 5')
    end

    should 'raise exception if device type is not found' do
      assert_raises { SimCtl.devicetype(name: 'iPhone 1') }
    end
  end

  context 'list_devicetypes' do
    should 'contain some devicetypes' do
      assert SimCtl.list_devicetypes.count > 0
    end

    should 'be a SimCtl::DeviceType object' do
      assert_kind_of SimCtl::DeviceType, SimCtl.list_devicetypes.first
    end

    should 'parse identifier property' do
      assert SimCtl.list_devicetypes.first.identifier != nil
    end

    should 'parse name property' do
      assert SimCtl.list_devicetypes.first.name != nil
    end
  end

  context 'list_runtimes' do
    should 'contain some runtimes' do
      assert SimCtl.list_runtimes.count > 0
    end

    should 'be a SimCtl::Runtime object' do
      assert_kind_of SimCtl::Runtime, SimCtl.list_runtimes.first
    end

    should 'parse availability property' do
      assert SimCtl.list_runtimes.first.availability != nil
    end

    should 'parse buildversion property' do
      assert SimCtl.list_runtimes.first.buildversion != nil
    end

    should 'parse identifier property' do
      assert SimCtl.list_runtimes.first.identifier != nil
    end

    should 'parse name property' do
      assert SimCtl.list_runtimes.first.name != nil
    end

    should 'return latest ios runtime' do
      assert_kind_of SimCtl::Runtime, SimCtl::Runtime.latest(:ios)
    end

    should 'return latest tvos runtime' do
      assert_kind_of SimCtl::Runtime, SimCtl::Runtime.latest(:tvos)
    end

    should 'return latest watchos runtime' do
      assert_kind_of SimCtl::Runtime, SimCtl::Runtime.latest(:watchos)
    end
  end

  context 'runtime' do
    should 'find runtime by name' do
      assert_kind_of SimCtl::Runtime, SimCtl.runtime(name: 'iOS 9.3')
    end

    should 'raise exception if runtime is not found' do
      assert_raises { SimCtl.runtime(name: 'iOS 17.0') }
    end
  end

  context 'unknown method' do
    should 'raise an exception' do
      assert_raises { SimCtl.foo }
    end
  end

end
