require "rails_helper"

RSpec.describe Places::VideosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/places/videos").to route_to("places/videos#index")
    end


    it "routes to #show" do
      expect(:get => "/places/videos/1").to route_to("places/videos#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/places/videos").to route_to("places/videos#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/places/videos/1").to route_to("places/videos#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/places/videos/1").to route_to("places/videos#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/places/videos/1").to route_to("places/videos#destroy", :id => "1")
    end

  end
end
