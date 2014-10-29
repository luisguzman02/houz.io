require "spec_helper"

RSpec.describe RatesController, type: :routing do
  describe "routing" do

    context 'when is under root path' do
      it "routes to #index" do
        expect(get("/rates")).to route_to("rates#index")
      end

      it "routes to #new" do
        expect(get("/rates/new")).to route_to("rates#new")
      end

      it "routes to #show" do
        expect(get("/rates/1")).to route_to("rates#show", :id => "1")
      end

      it "routes to #edit" do
        expect(get("/rates/1/edit")).to route_to("rates#edit", :id => "1")
      end

      it "routes to #create" do
        expect(post("/rates")).to route_to("rates#create")
      end

      it "routes to #update" do
        expect(put("/rates/1")).to route_to("rates#update", :id => "1")
      end

      it "routes to #destroy" do
        expect(delete("/rates/1")).to route_to("rates#destroy", :id => "1")
      end
    end

    context 'when is under property path' do
      it "routes to #index" do
        expect(get("/properties/1/rates")).to route_to("rates#index", :property_id => '1')
      end

      it "routes to #new" do
        expect(get("/properties/1/rates/new")).to route_to("rates#new", :property_id => '1')
      end

      it "routes to #show" do
        expect(get("/properties/1/rates/1")).to route_to("rates#show", :property_id => '1', :id => "1")
      end

      it "routes to #edit" do
        expect(get("/properties/1/rates/1/edit")).to route_to("rates#edit", :property_id => '1', :id => "1")
      end

      it "routes to #create" do
        expect(post("/properties/1/rates")).to route_to("rates#create", :property_id => '1')
      end

      it "routes to #update" do
        expect(put("/properties/1/rates/1")).to route_to("rates#update", :property_id => '1', :id => "1")
      end

      it "routes to #destroy" do
        expect(delete("/properties/1/rates/1")).to route_to("rates#destroy", :property_id => '1', :id => "1")
      end
    end
  end
end
