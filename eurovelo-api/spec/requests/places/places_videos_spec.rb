require 'rails_helper'

RSpec.describe "Places::Videos", type: :request do
  describe "GET /places_videos" do
    it "works! (now write some real specs)" do
      get places_videos_path
      expect(response).to have_http_status(200)
    end
  end
end
