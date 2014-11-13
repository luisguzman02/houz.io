require 'spec_helper'

RSpec.describe PropertiesController, type: :controller do
  let(:account) { FactoryGirl.create(:account) }
  let(:user) { account.user }

  # This should return the minimal set of attributes required to create a valid
  # Property. As you add validations to Property, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { :name => 'Bacum ipsum', 
      :unit_type => :condo, 
      :contact => FactoryGirl.build(:contact), 
      :description => 'Rump kielbasa swine bacon ham venison. Boudin salami pastrami cow kevin frankfurter pork belly turducken jowl', 
      :active => true, 
      :account => account, 
      :user => user}
  end

  before(:each) do 
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user.confirm!
    sign_in user
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # PropertiesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all properties as @properties" do
      property = Property.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:properties)).to eq([property])
      expect(response.status).to eq(200)
    end
  end

  describe "GET show" do
    it "assigns the requested property as @property" do
      property = Property.create! valid_attributes
      get :show, {:id => property.to_param}, valid_session
      expect(assigns(:property)).to eq(property)
      expect(response.status).to eq(200)
    end
  end

  describe "GET new" do
    it "assigns a new property as @property" do
      get :new, {}, valid_session
      expect(assigns(:property)).to be_a_new(Property)
      expect(response.status).to eq(200)
    end
  end

  describe "GET edit" do
    it "assigns the requested property as @property" do
      property = Property.create! valid_attributes
      get :edit, {:id => property.to_param}, valid_session
      expect(assigns(:property)).to eq(property)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Property" do
        expect {
          post :create, {:property => valid_attributes}, valid_session          
        }.to change(Property, :count).by(1)
      end

      it "assigns a newly created property as @property" do
        post :create, {:property => valid_attributes}, valid_session
        expect(assigns(:property)).to be_a(Property)
        expect(assigns(:property)).to be_persisted
      end

      it "redirects to the created property" do
        post :create, {:property => valid_attributes}, valid_session
        expect(response).to redirect_to( property_path(Property.last) )
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved property as @property" do
        # Trigger the behavior that occurs when invalid params are submitted
        Property.any_instance.stub(:save).and_return(false)
        post :create, {:property => {  }}, valid_session
        expect(assigns(:property)).to be_a_new(Property)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Property.any_instance.stub(:save).and_return(false)
        post :create, {:property => {  }}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested property" do
        property = Property.create! valid_attributes
        # Assuming there are no other properties in the database, this
        # specifies that the Property created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Property.any_instance.should_receive(:update).with({ "name" => "Lorem ipsum" })
        put :update, {:id => property.to_param, :property => { "name" => "Lorem ipsum" }}, valid_session
      end

      it "assigns the requested property as @property" do
        property = Property.create! valid_attributes
        put :update, {:id => property.to_param, :property => valid_attributes}, valid_session
        expect(assigns(:property)).to eq(property)
      end

      it "redirects to the property" do
        property = Property.create! valid_attributes
        put :update, {:id => property.to_param, :property => valid_attributes}, valid_session
        expect(response).to redirect_to(property)
      end
    end

    describe "with invalid params" do
      it "assigns the property as @property" do
        property = Property.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Property.any_instance.stub(:save).and_return(false)
        put :update, {:id => property.to_param, :property => {  }}, valid_session
        expect(assigns(:property)).to eq(property)
      end

      it "re-renders the 'edit' template" do
        property = Property.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Property.any_instance.stub(:save).and_return(false)
        put :update, {:id => property.to_param, :property => {  }}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested property" do
      property = Property.create! valid_attributes
      expect {
        delete :destroy, {:id => property.to_param}, valid_session
      }.to change(Property, :count).by(-1)
    end

    it "redirects to the properties list" do
      property = Property.create! valid_attributes
      delete :destroy, {:id => property.to_param}, valid_session
      expect(response).to redirect_to(properties_url)
    end
  end

end
