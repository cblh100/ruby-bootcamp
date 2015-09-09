module Wait

  class BlockTimeoutError < StandardError
  end

  def self.until(retry_time = 0, expire_after = 5)

    raise ArgumentError, 'You must provide a block to execute' if !block_given?

    expiry_time = Time.now + expire_after

    result = yield

    until result || Time.now >= expiry_time do
      sleep retry_time
      result = yield
    end

    raise BlockTimeoutError, 'Block failed to succeed within expiry time' if !result

  end

end