module RequestAPI
  def body_json
    JSON.parse(response.body)
  end

  def authenticated_header(user = nil)
    user ||= create(:user)

    post api_v1_sign_in_path, params: { user: { email: user.email, password: user.password } }

    response.headers.slice("Authorization")
  end
end

RSpec.configure do |config|
  config.include RequestAPI, type: :request
end
