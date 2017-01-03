require 'spec_helper'

RSpec.describe SimCtl do
  describe '#warmup' do
    context 'when simulator version is >= 9.0' do
      if SimCtl.device_set_path.nil?
        it 'warms up and returns a device for given strings' do
          expect(SimCtl.warmup('iPhone 6', 'iOS 9.3')).to be_kind_of SimCtl::Device
        end

        it 'warms up and returns a device for given objects' do
          devicetype = SimCtl.devicetype(name: 'iPhone 5')
          runtime = SimCtl::Runtime.latest(:ios)
          expect(SimCtl.warmup(devicetype, runtime)).to be_kind_of SimCtl::Device
        end
      else
        it 'raises exception' do
          expect { SimCtl.warmup('iPhone 6', 'iOS 9.3') }.to raise_error SimCtl::DeviceNotFound
        end
      end
    end

    context 'when simulator version is < 9.0' do
      if SimCtl.device_set_path.nil?
        it 'warms up and returns a device for given strings' do
          expect(SimCtl.warmup('iPhone 5', 'iOS 8.4')).to be_kind_of SimCtl::Device
        end

        it 'warms up and returns a device for given objects' do
          devicetype = SimCtl.devicetype(name: 'iPhone 5')
          runtime = SimCtl.runtime(name: 'iOS 8.4')
          expect(SimCtl.warmup(devicetype, runtime)).to be_kind_of SimCtl::Device
        end
      else
        it 'raises exception' do
          expect { SimCtl.warmup('iPhone 6', 'iOS 9.3') }.to raise_error SimCtl::DeviceNotFound
        end
      end
    end
  end
end
