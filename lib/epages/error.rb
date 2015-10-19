module Epages
  class Error < StandardError
    attr_reader :code

    # Raised when a 4xx HTTP status code is returned
    ClientError = Class.new(self)

    # HTTP status code 400, 401, 403, 404, 406, 422, 429 respectively
    BadRequest =          Class.new(ClientError)
    Unauthorized =        Class.new(ClientError)
    Forbidden =           Class.new(ClientError)
    NotFound =            Class.new(ClientError)
    NotAcceptable =       Class.new(ClientError)
    UnprocessableEntity = Class.new(ClientError)
    TooManyRequests =     Class.new(ClientError)

    # Raised when a 5xx HTTP status code is returned
    ServerError = Class.new(self)

    # HTTP status code 500, 502, 503, 504 respectively
    InternalServerError = Class.new(ServerError)
    BadGateway =          Class.new(ServerError)
    ServiceUnavailable =  Class.new(ServerError)
    GatewayTimeout =      Class.new(ServerError)

    ERRORS = {
        400 => Epages::Error::BadRequest,
        401 => Epages::Error::Unauthorized,
        403 => Epages::Error::Forbidden,
        404 => Epages::Error::NotFound,
        406 => Epages::Error::NotAcceptable,
        422 => Epages::Error::UnprocessableEntity,
        429 => Epages::Error::TooManyRequests,
        500 => Epages::Error::InternalServerError,
        502 => Epages::Error::BadGateway,
        503 => Epages::Error::ServiceUnavailable,
        504 => Epages::Error::GatewayTimeout,
    }

    private

    def parse_error(body)
      if body.nil? || body.empty?
        ['', nil]
      elsif body[:error]
        [body[:error], nil]
      elsif body[:errors]
        extract_message_from_errors(body)
      end
    end

    def extract_message_from_errors(body)
      first = Array(body[:errors]).first
      if first.is_a?(Hash)
        [first[:message].chomp, first[:code]]
      else
        [first.chomp, nil]
      end
    end
  end
end