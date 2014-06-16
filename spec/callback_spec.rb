class ThingWithCallbacks
  def succeeder(arg1, arg2, &block)
    if arg1 == 'hello'
      yield Callback.new(:success, 'success')
    else
      yield Callback.new(:failure, 'failure')
    end
  end
end

class ThingWithClassLevelCallbacks
  class << self
    def succeeder(arg1, arg2, &block)
      if arg1 == 'hello'
        yield Callback.new(:success, 'success')
      else
        yield Callback.new(:failure, 'failure')
      end
    end

    def fxn_with_no_args(&block)
      yield Callback.new(:success, 'success')
    end
  end
end

describe 'Callback' do
  before do
    @thing = ThingWithCallbacks.new
  end

  describe "provides for success and failure callbacks" do
    it "success" do
      result = nil
      @thing.succeeder 'hello', 'world' do |on|
        on.success {|value| result = value}
      end
      result.should == 'success'
    end

    it "failure" do
      result = nil
      @thing.succeeder 'goodbye', 'world' do |on|
        on.failure {|value| result = value}
      end
      result.should == 'failure'
    end

    describe "multibranch" do
      before do
        @success_val = 'unmodified'
        @failure_val = 'unmodified'
      end

      it "success case" do
        @thing.succeeder 'hello', 'world' do |on|
          on.success {|value| @success_val = value}
          on.failure {|value| @failure_val = value}
        end
        @success_val.should == 'success'
        @failure_val.should == 'unmodified'
      end

      it "failure case" do
        @thing.succeeder 'goodbye', 'world' do |on|
          on.success {|value| @success_val = value}
          on.failure {|value| @failure_val = value}
        end
        @success_val.should == 'unmodified'
        @failure_val.should == 'failure'
      end
    end

  end
end

describe 'Class level callbacks' do
  describe "provides for success and failure callbacks" do
    it "success" do
      result = nil
      ThingWithClassLevelCallbacks.succeeder 'hello', 'world' do |on|
        on.success {|value| result = value}
      end
      result.should == 'success'
    end

    it "failure" do
      result = nil
      ThingWithClassLevelCallbacks.succeeder 'goodbye', 'world' do |on|
        on.failure {|value| result = value}
      end
      result.should == 'failure'
    end

    describe "multibranch" do
      before do
        @success_val = 'unmodified'
        @failure_val = 'unmodified'
      end

      it "success case" do
        ThingWithClassLevelCallbacks.succeeder 'hello', 'world' do |on|
          on.success {|value| @success_val = value}
          on.failure {|value| @failure_val = value}
        end
        @success_val.should == 'success'
        @failure_val.should == 'unmodified'
      end

      it "failure case" do
        ThingWithClassLevelCallbacks.succeeder 'goodbye', 'world' do |on|
          on.success {|value| @success_val = value}
          on.failure {|value| @failure_val = value}
        end
        @success_val.should == 'unmodified'
        @failure_val.should == 'failure'
      end
    end

    it "works with a function that takes no arguments" do
      ThingWithClassLevelCallbacks.fxn_with_no_args do |on|
        on.success {|value| @success_val = value}
        @success_val.should == 'success'
      end
    end
  end
end
