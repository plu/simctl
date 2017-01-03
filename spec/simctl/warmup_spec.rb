require 'spec_helper'

RSpec.describe SimCtl do
  describe '#warmup' do
    RSpec.shared_examples 'warmup examples' do |parameters|
      let (:device_name) { parameters[:device] }
      let (:runtime_name) { parameters[:runtime] }

      if SimCtl.device_set_path.nil?
        it 'warms up and returns a device for given strings' do
          expect(SimCtl.warmup(device_name, runtime_name)).to be_kind_of SimCtl::Device
        end

        it 'warms up and returns a device for given objects' do
          devicetype = SimCtl.devicetype(name: device_name)
          runtime = SimCtl.runtime(name: runtime_name)
          expect(SimCtl.warmup(devicetype, runtime)).to be_kind_of SimCtl::Device
        end
      else
        it 'raises exception' do
          expect { SimCtl.warmup(device_name, runtime_name) }.to raise_error SimCtl::DeviceNotFound
        end
      end
    end

    context 'when simulator version is >= 9.0' do
      include_examples 'warmup examples', {device: 'iPhone 6', runtime: 'iOS 9.3'}
    end

    context 'when simulator version is < 9.0' do
      include_examples 'warmup examples', {device: 'iPhone 5', runtime: 'iOS 8.4'}
    end
  end
end
