class ReservationsController < DashboardController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy, :edit_notes]
  before_action :set_reservation_guest, :only => [:edit]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = ReservationDecorator.decorate_collection(current_user.reservations.order_by(:created_at => :desc))    
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = current_user.reservations.build
    respond_to do |format|
      format.html { }
      format.js
    end
  end

  # GET /reservations/1/edit
  def edit    
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = current_user.reservations.build  reservation_params    
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to @reservation, notice: 'Reservation was successfully created.' }
        format.json { render action: 'show', status: :created, location: @reservation }
        format.js { set_reservation_guest }
      else
        format.html { render action: 'new' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
        format.js { }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update    
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { head :no_content }
        format.js { }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
        format.js { }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.discard
    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = current_user.reservations.find(params[:id])
      @reservation = @reservation.decorate if @reservation.present?
    end

    def set_reservation_guest
      @reservation.guest.contact.build_address if @reservation.guest.contact.address.nil?
      @reservation.guest.contact.phones.build if @reservation.guest.contact.phones.empty?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:check_in, :check_out, :num_adults, :num_children, :property_id, :rsv_type, :notes, :guest_attributes => [:name, :email, :source, 
        :contact_attributes => {:address_attributes =>  [:country, :city, :state, :street], :phones_attributes => [:number] }])
    end
end
