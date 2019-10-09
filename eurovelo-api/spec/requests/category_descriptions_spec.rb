require 'rails_helper'

RSpec.describe "CategoryDescriptions", type: :request do
  describe "GET /category_descriptions" do
    it "works! (now write some real specs)" do
      get category_descriptions_path
      expect(response).to have_http_status(200)
    end
  end
end
