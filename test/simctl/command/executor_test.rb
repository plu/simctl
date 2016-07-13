require 'securerandom'
require 'test_helper'

class SimCtl::Command::ExecutorTest < Minitest::Test
  should 'raise exception' do
    assert_raises { SimCtl::Executor.execute(['xcrun simctl asdf']) }
  end

  should 'return json' do
    json = SimCtl::Executor.execute(["echo '{\"foo\":\"bar\"}'"]) do |result|
      result
    end
    assert json == {'foo' => 'bar'}
  end

  should 'return string' do
    string = SimCtl::Executor.execute(["echo 'hello world'"]) do |result|
      result
    end
    assert string == 'hello world'
  end
end
