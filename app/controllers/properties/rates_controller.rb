module Properties
  class RatesController < DashboardController
    before_action :load_concern
    before_action :set_rate, only: [:show, :edit, :update, :destroy]  

    def index 
      @rates = @concern_o.rates    
    end

    def show
    end

    def new
      @rate = Rate.new
    end

    def edit
    end

    def create
      @rate = @property.rates.build rate_params
      respond_to do |format|
        if @rate.save
          format.html { redirect_to property_rates_path(@property), notice: 'Rate was successfully created.' }
          format.json { render action: 'show', status: :created, location: @rate }
          format.js { flash[:notice] = 'Rate was successfully created.' }
        else
          format.html { render action: 'new' }
          format.json { render json: @rate.errors, status: :unprocessable_entity }
          format.js { }
        end
      end
    end

    def update
      respond_to do |format|
        if @rate.update(rate_params)
          format.html { redirect_to rates_path, notice: 'Rate was successfully updated.' }
          format.json { head :no_content }
          format.js { }
        else
          format.html { render action: 'edit' }
          format.json { render json: @rate.errors, status: :unprocessable_entity }
          format.js { }
        end
      end
    end

    def destroy
      @rate.destroy
      respond_to do |format|
        format.html { redirect_to property_rates_path(@property), notice: 'Rate was successfully deleted.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_rate
        @rate = @property.rates.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def rate_params
        params.require(:rate).permit(:name, :type, :always_apply, :hold_for_return, :value_type, :value, :seasonable, :start_season, :end_season) if params[:rate].present?
      end

      def load_concern
        @concern_o = current_account
        if params[:property_id].present? 
          @concern_id = params[:property_id]     
          @property = @concern_o = current_account.properties.find(@concern_id)   
        end
        @rates = @concern_o.rates  
      end
  end
end