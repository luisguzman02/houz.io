require "spec_helper"

RSpec.describe Properties::PicturesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get("/properties/1/pictures")).to route_to("properties/pictures#index", :property_id => '1')
    end

    it "routes to #new" do
      expect(get("/properties/1/pictures/new")).to route_to("properties/pictures#new", :property_id => '1')
    end

    it "routes to #show" do
      expect(get("/properties/1/pictures/1")).to route_to("properties/pictures#show", :id => "1", :property_id => '1')
    end

    it "routes to #edit" do
      expect(get("/properties/1/pictures/1/edit")).to route_to("properties/pictures#edit", :id => "1", :property_id => '1')
    end

    it "routes to #create" do
      expect(post("/properties/1/pictures")).to route_to("properties/pictures#create", :property_id => '1')
    end

    it "routes to #update" do
      expect(put("/properties/1/pictures/1")).to route_to("properties/pictures#update", :id => "1", :property_id => '1')
    end

    it "routes to #destroy" do
      expect(delete("/properties/1/pictures/1")).to route_to("properties/pictures#destroy", :id => "1", :property_id => '1')
    end

  end
end
