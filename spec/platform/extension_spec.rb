require 'ronin/platform/extension'

require 'spec_helper'

describe Platform::Extension do
  before(:each) do
    @ext = Platform::Extension.new('test') do
      attr_reader :var
      attr_writer :var

      setup do
        @var = :setup
      end

      teardown do
        @var = :toredown
      end

      def test_method
        :method
      end

      def run_method
        @var = :running
      end
    end
  end

  it "should allow for custom methods" do
    @ext.has_method?(:test_method).should == true
    @ext.test_method.should == :method
  end

  it "should have a setup state" do
    @ext.setup!
    @ext.should be_setup
  end

  it "should have setup blocks" do
    @ext.setup!
    @ext.instance_eval { @var }.should == :setup
  end

  it "should have a toredown state" do
    @ext.teardown!
    @ext.should be_toredown
  end

  it "should have teardown blocks" do
    @ext.setup!
    @ext.teardown!
    @ext.instance_eval { @var }.should == :toredown
  end

  it "should not be torendown before it is setup" do
    @ext.teardown!
    @ext.instance_eval { @var }.should be_nil
  end

  it "should be able to be ran" do
    @ext.run do |ext|
      ext.run_method.should == :running
    end
  end

  it "should allow the definition of reader and writer methods" do
    @ext.run do |ext|
      ext.var.should == :setup
      ext.var = :random
      ext.var.should == :random
    end
  end
end
