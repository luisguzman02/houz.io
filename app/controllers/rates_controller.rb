class RatesController < DashboardController
  before_action :set_rate, only: [:show, :edit, :update, :destroy]
  before_action :only => [:index, :edit, :update, :new, :create] {@rates = current_account.rates }

  # GET /rates
  # GET /rates.json
  def index    
  end

  # GET /rates/1
  # GET /rates/1.json
  def show
  end

  # GET /rates/new
  def new
    @rate = Rate.new
  end

  # GET /rates/1/edit
  def edit
  end

  # POST /rates
  # POST /rates.json
  def create
    @rate = current_account.rates.build rate_params
    respond_to do |format|
      if @rate.save
        format.html { redirect_to rates_path, notice: 'Rate was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rate }
      else
        format.html { render action: 'new' }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rates/1
  # PATCH/PUT /rates/1.json
  def update
    respond_to do |format|
      if @rate.update(rate_params)
        format.html { redirect_to rates_path, notice: 'Rate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rates/1
  # DELETE /rates/1.json
  def destroy
    @rate.destroy
    respond_to do |format|
      format.html { redirect_to rates_url, notice: 'Rate was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = current_account.rates.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_params
      params.require(:rate).permit(:name, :type, :always_apply, :hold_for_return, :value_type, :value, :seasonable, :start_season, :end_season)
    end
end
