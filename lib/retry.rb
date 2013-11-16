module Retry
  def self.on_exception(exception_class, &block)
    with_wait(exception_class, 1, 0, false) do
      yield
    end
  end

  def self.several_times(exception_class, retries, &block)
    with_wait(exception_class, retries, 0, false) do
      yield
    end
  end

  def self.with_delay(exception_class, retries, seconds_to_wait, &block)
    with_wait(exception_class, retries, seconds_to_wait, false) do
      yield
    end
  end

  def self.with_exponential_backoff(exception_class, retries, base_seconds, &block)
    with_wait(exception_class, retries, base_seconds, true) do
      yield
    end
  end

  def self.with_wait(exception_class, retries, base_seconds, exponential_backoff, &block)
    retries.times do |attempt|
      begin
        yield
      rescue exception_class
        sleep(base_seconds ** (attempt + 1)) if exponential_backoff
        sleep(base_seconds) unless exponential_backoff
      else
        return
      end
    end
    yield
  end
end
