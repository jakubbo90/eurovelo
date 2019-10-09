require 'rails_helper'

RSpec.describe "PasswordExpirations", type: :request do
  describe "GET /password_expirations" do
    it "works! (now write some real specs)" do
      get password_expirations_path
      expect(response).to have_http_status(200)
    end
  end
end
