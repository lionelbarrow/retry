require "spec_helper"

describe Retry do
  describe "_with_options" do
    it "retries if the correct exception is thrown" do
      Retry.should_receive(:sleep).once

      count = 0
      Retry._with_options(DummyError, 1, 1, true) do
        count += 1
        raise DummyError if count == 1
      end
      count.should == 2
    end

    it "lets the exception propogate if it does not match" do
      expect do
        Retry._with_options(DummyError, 1, 1, true) do
          raise
        end
      end.to raise_error
    end

    it "sleeps an increasing number of seconds in between attempts" do
      Retry.should_receive(:sleep).with(2).once
      Retry.should_receive(:sleep).with(4).once

      count = 0
      Retry._with_options(DummyError, 2, 2, true) do
        count += 1
        raise DummyError unless count == 3
      end
    end

    it "tries to retry the number of times specified" do
      Retry.should_receive(:sleep).exactly(4).times

      count = 0
      Retry._with_options(DummyError, 4, 1, true) do
        count += 1
        raise DummyError if count < 5
      end
      count.should == 5
    end

    it "allows the exception to pass through after the retries have been exhausted" do
      Retry.should_receive(:sleep).with(1).exactly(2).times

      count = 0
      expect do
        Retry._with_options(DummyError, 2, 1, true) do
          count += 1
          raise DummyError if count < 4
        end
      end.to raise_error(DummyError)
      count.should == 3
    end
  end

  describe "with_delay" do
    it "sleeps a constant amount of time between attempts" do
      Retry.should_receive(:sleep).with(1).exactly(3).times

      count = 0
      Retry.with_delay(DummyError, 4, 1) do
        count += 1
        raise DummyError unless count == 4
      end
      count.should == 4
    end
  end

  describe "with_exponential_backoff" do
    it "sleeps an increasing amount of time between attempts" do
      Retry.should_receive(:sleep).with(3).once
      Retry.should_receive(:sleep).with(9).once
      Retry.should_receive(:sleep).with(27).once

      count = 0
      Retry.with_exponential_backoff(DummyError, 3, 3) do
        count += 1
        raise DummyError unless count == 4
      end
    end
  end

  describe "several_times" do
    it "retries the specified number of times" do
      count = 0
      Retry.several_times(DummyError, 3) do
        count += 1
        raise DummyError unless count == 4
      end
      count.should == 4
    end
  end

  describe "on_exception" do
    it "retries once" do
      count = 0
      Retry.on_exception(DummyError) do
        count += 1
        raise DummyError unless count == 2
      end
      count.should == 2
    end
  end
end
