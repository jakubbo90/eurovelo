require "rails_helper"

RSpec.describe CategoryDescriptionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/category_descriptions").to route_to("category_descriptions#index")
    end


    it "routes to #show" do
      expect(:get => "/category_descriptions/1").to route_to("category_descriptions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/category_descriptions").to route_to("category_descriptions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/category_descriptions/1").to route_to("category_descriptions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/category_descriptions/1").to route_to("category_descriptions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/category_descriptions/1").to route_to("category_descriptions#destroy", :id => "1")
    end

  end
end
