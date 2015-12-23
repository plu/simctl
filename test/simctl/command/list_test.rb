require 'test_helper'

class SimCtl::Command::ListTest < Minitest::Test
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
  end
end
