require "rails_helper"

RSpec.describe "Authentication", type: :request do
  let!(:user) do
    User.create!(
      email: "user@test.com",
      password: "password123",
      role: :customer
    )
  end

  it "allows user to sign in" do
    post user_session_path, params: {
      user: {
        email: user.email,
        password: "password123"
      }
    }

    follow_redirect!

    expect(response).to have_http_status(:success)
    expect(response.body).not_to include("Sign in")
  end
end
