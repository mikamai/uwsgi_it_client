class Poster
  include HTTParty
  format :json

  attr_reader :result

  def initialize(url, body, auth_data)
    @result = post url, body: body, basic_auth: auth_data
  end

  private

  def post(*args)
    self.class.post *args
  end
end