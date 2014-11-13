require "spec_helper"

RSpec.describe Properties::RatesController, type: :routing do
  describe "routing" do

    context 'when is under root path' do
      it "routes to #index" do
        expect(get("/properties/1/rates")).to route_to("properties/rates#index", :property_id => '1')
      end

      it "routes to #new" do
        expect(get("/properties/1/rates/new")).to route_to("properties/rates#new", :property_id => '1')
      end

      it "routes to #show" do
        expect(get("/properties/1/rates/1")).to route_to("properties/rates#show", :id => "1", :property_id => '1')
      end

      it "routes to #edit" do
        expect(get("/properties/1/rates/1/edit")).to route_to("properties/rates#edit", :id => "1", :property_id => '1')
      end

      it "routes to #create" do
        expect(post("/properties/1/rates")).to route_to("properties/rates#create", :property_id => '1')
      end

      it "routes to #update" do
        expect(put("/properties/1/rates/1")).to route_to("properties/rates#update", :property_id => '1', :id => "1")
      end

      it "routes to #destroy" do
        expect(delete("/properties/1/rates/1")).to route_to("properties/rates#destroy", :property_id => '1', :id => "1")
      end
    end
    
  end
end
