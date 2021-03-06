require 'spec_helper'

RSpec.describe ReservationsController, type: :controller do
  let(:account) { FactoryGirl.create(:account) }
  let(:user) { account.user }
  let(:property) { FactoryGirl.create(:property, :account => account, :user => account.user) }
  # This should return the minimal set of attributes required to create a valid
  # Reservation. As you add validations to Reservation, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { :rsv_type => :regular, 
      :check_in => Date.today,
      :check_out => Date.tomorrow, 
      :user => user, 
      :property_id => property.id, 
      :account_id => account.id}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ReservationsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) do 
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user.confirm!
    sign_in user
  end

  describe "GET index" do
    it "assigns all reservations as @reservations" do
     reservation = Reservation.create! valid_attributes
      get :index, {}, valid_session
      assigns(:reservations).should eq([reservation])
    end
  end

  describe "GET show" do
    it "assigns the requested reservation as @reservation" do
      reservation = Reservation.create! valid_attributes
      get :show, {:id => reservation.to_param}, valid_session
      assigns(:reservation).should eq(reservation)
    end
  end

  describe "GET new" do
    it "assigns a new reservation as @reservation" do
      get :new, {}, valid_session
      assigns(:reservation).should be_a_new(Reservation)
    end
  end

  describe "GET edit" do
    it "assigns the requested reservation as @reservation" do
      reservation = Reservation.create! valid_attributes
      get :edit, {:id => reservation.to_param}, valid_session
      assigns(:reservation).should eq(reservation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Reservation" do
        expect {
          post :create, {:reservation => valid_attributes}, valid_session
        }.to change(Reservation, :count).by(1)
      end

      it "assigns a newly created reservation as @reservation" do
        post :create, {:reservation => valid_attributes}, valid_session
        assigns(:reservation).should be_a(Reservation)
        assigns(:reservation).should be_persisted
      end

      it "redirects to the created reservation" do
        post :create, {:reservation => valid_attributes}, valid_session
        response.should redirect_to(Reservation.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved reservation as @reservation" do
        # Trigger the behavior that occurs when invalid params are submitted
        Reservation.any_instance.stub(:save).and_return(false)
        post :create, {:reservation => {  }}, valid_session
        assigns(:reservation).should be_a_new(Reservation)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Reservation.any_instance.stub(:save).and_return(false)
        post :create, {:reservation => {  }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested reservation" do
        reservation = Reservation.create! valid_attributes
        # Assuming there are no other reservations in the database, this
        # specifies that the Reservation created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Reservation.any_instance.should_receive(:update).with({ "rsv_type" => 'owner_time'})
        put :update, {:id => reservation.to_param, :reservation => { "rsv_type" => :owner_time}}, valid_session
      end

      it "assigns the requested reservation as @reservation" do
        reservation = Reservation.create! valid_attributes
        put :update, {:id => reservation.to_param, :reservation => valid_attributes}, valid_session
        assigns(:reservation).should eq(reservation)
      end

      it "redirects to the reservation" do
        reservation = Reservation.create! valid_attributes
        put :update, {:id => reservation.to_param, :reservation => valid_attributes}, valid_session
        response.should redirect_to(reservation)
      end
    end

    describe "with invalid params" do
      it "assigns the reservation as @reservation" do
        reservation = Reservation.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Reservation.any_instance.stub(:save).and_return(false)
        put :update, {:id => reservation.to_param, :reservation => {  }}, valid_session
        assigns(:reservation).should eq(reservation)
      end

      it "re-renders the 'edit' template" do
        reservation = Reservation.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Reservation.any_instance.stub(:save).and_return(false)
        put :update, {:id => reservation.to_param, :reservation => {  }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested reservation" do
      reservation = Reservation.create! valid_attributes
      expect {
        delete :destroy, {:id => reservation.to_param}, valid_session
      }.to change(Reservation, :count).by(-1)
    end

    it "redirects to the reservations list" do
      reservation = Reservation.create! valid_attributes
      delete :destroy, {:id => reservation.to_param}, valid_session
      response.should redirect_to(reservations_url)
    end
  end

end
