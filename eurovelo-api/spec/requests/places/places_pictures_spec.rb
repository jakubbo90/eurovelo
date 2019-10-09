require 'rails_helper'

RSpec.describe "Places::Pictures", type: :request do
  describe "GET /places_pictures" do
    it "works! (now write some real specs)" do
      get places_pictures_path
      expect(response).to have_http_status(200)
    end
  end
end
