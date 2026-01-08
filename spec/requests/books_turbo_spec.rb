require "rails_helper"

RSpec.describe "Books Turbo Search", type: :request do
  before do
    Book.create!(
      title: "Mumbai Stories",
      author: "Test Author",
      price: 300
    )
  end

  it "returns turbo frame response" do
    get books_path,
        params: { query: "Mumbai" },
        headers: { "Turbo-Frame" => "books_list" }

    expect(response).to have_http_status(:success)
    expect(response.body).to include("turbo-frame")
    expect(response.body).to include("Mumbai Stories")
  end
end
