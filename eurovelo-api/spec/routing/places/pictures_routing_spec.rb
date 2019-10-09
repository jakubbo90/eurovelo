require "rails_helper"

RSpec.describe Places::PicturesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/places/pictures").to route_to("places/pictures#index")
    end


    it "routes to #show" do
      expect(:get => "/places/pictures/1").to route_to("places/pictures#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/places/pictures").to route_to("places/pictures#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/places/pictures/1").to route_to("places/pictures#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/places/pictures/1").to route_to("places/pictures#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/places/pictures/1").to route_to("places/pictures#destroy", :id => "1")
    end

  end
end
