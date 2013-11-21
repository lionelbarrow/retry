module Retry
  def self.on_exception(exception_class, &block)
    _with_options(exception_class, 1, 0, false, &block)
  end

  def self.several_times(exception_class, retries, &block)
    _with_options(exception_class, retries, 0, false, &block)
  end

  def self.with_delay(exception_class, retries, seconds_to_wait, &block)
    _with_options(exception_class, retries, seconds_to_wait, false, &block)
  end

  def self.with_exponential_backoff(exception_class, retries, base_seconds, &block)
    _with_options(exception_class, retries, base_seconds, true, &block)
  end

  def self._with_options(exception_class, retries, base_seconds, exponential_backoff, &block)
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
