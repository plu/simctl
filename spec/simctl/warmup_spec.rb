require 'spec_helper'

RSpec.describe SimCtl do
  describe '#warmup' do
    if SimCtl.device_set_path.nil?
      it 'warms up and returns a device' do
        expect(SimCtl.warmup('iPhone 6', 'iOS 10.1')).to be_kind_of SimCtl::Device
      end
    else
      it 'raises exception' do
        expect { SimCtl.warmup('iPhone 6', 'iOS 10.1') }.to raise_error SimCtl::DeviceNotFound
      end
    end
  end
end
