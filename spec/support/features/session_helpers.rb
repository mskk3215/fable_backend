# frozen_string_literal: true

module Features
  module SessionHelpers
    def json
      JSON.parse(response.body)
    end

    def login(user)
      post api_v1_login_path, params: { session: { email: user.email, password: user.password } }
    end
  end
end
