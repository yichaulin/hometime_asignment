class Clients::Errors
  attr_reader :http_status, :message

  def initialize(msg, http_status)
    @message = msg
    @http_status = http_status
  end

  def to_s()
    @message
  end

  def as_json(options)
    @message
  end

  def inspect
    @message
  end
end