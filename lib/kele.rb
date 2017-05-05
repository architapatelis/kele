# We place the code for a gem within the lib directory.
# gets loaded when we call require './lib/kele'

require "httparty"

class Kele
  include HTTParty

  def initialize(email, password)
    @email = email
    @password = password
    @bloc_base_api_url = "https://www.bloc.io/api/v1"
    @authorization_token = self.class.post("https://www.bloc.io/api/v1/sessions", body: {email: @email, password: @password})

    raise "Wrong Email and/or Password" if @authorization_token.code != 200
  end
end
