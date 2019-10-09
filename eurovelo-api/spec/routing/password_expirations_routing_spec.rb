require "rails_helper"

RSpec.describe PasswordExpirationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/password_expirations").to route_to("password_expirations#index")
    end


    it "routes to #show" do
      expect(:get => "/password_expirations/1").to route_to("password_expirations#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/password_expirations").to route_to("password_expirations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/password_expirations/1").to route_to("password_expirations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/password_expirations/1").to route_to("password_expirations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/password_expirations/1").to route_to("password_expirations#destroy", :id => "1")
    end

  end
end
