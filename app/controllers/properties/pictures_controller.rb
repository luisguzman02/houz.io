module Properties
  class PicturesController < DashboardController
    before_action :load_property
    before_action :set_picture, only: [:show, :edit, :update, :destroy]

    def index
    end

    def show
    end

    def new
    end

    def edit
    end

    def create
      @picture = @property.pictures.new picture_params

      respond_to do |format|
        if @picture.save
          format.html { redirect_to property_pictures_path(@property), notice: 'Picture was successfully created.' }
          format.json { render action: 'show', status: :created, location: @picture }
        else
          format.html { render action: 'index' }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @picture.update(picture_params)
          format.html { redirect_to property_pictures_path(@property), notice: 'Picture was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @picture.destroy
      respond_to do |format|
        format.html { redirect_to property_pictures_path(@property) }
        format.json { head :no_content }
      end
    end

    private
      def load_property
        @property = current_account.properties.find(params[:property_id])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_picture
        @picture = @property.pictures.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def picture_params
        params.require(:picture).permit(:picture)
      end
  end
end