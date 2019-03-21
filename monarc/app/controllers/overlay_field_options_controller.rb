class OverlayFieldOptionsController < ApplicationController
  before_action :set_overlay_field_option, only: [:show, :edit, :update, :destroy]

  # GET /overlay_field_options
  # GET /overlay_field_options.json
  def index
    @overlay_field_options = OverlayFieldOption.all
  end

  # GET /overlay_field_options/1
  # GET /overlay_field_options/1.json
  def show
  end

  # GET /overlay_field_options/new
  def new
    @overlay_field_option = OverlayFieldOption.new
  end

  # GET /overlay_field_options/1/edit
  def edit
  end

  # POST /overlay_field_options
  # POST /overlay_field_options.json
  def create
    @overlay_field_option = OverlayFieldOption.new(overlay_field_option_params)

    respond_to do |format|
      if @overlay_field_option.save
        format.html { redirect_to @overlay_field_option, notice: 'Overlay field option was successfully created.' }
        format.json { render :show, status: :created, location: @overlay_field_option }
      else
        format.html { render :new }
        format.json { render json: @overlay_field_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /overlay_field_options/1
  # PATCH/PUT /overlay_field_options/1.json
  def update
    respond_to do |format|
      if @overlay_field_option.update(overlay_field_option_params)
        format.html { redirect_to @overlay_field_option, notice: 'Overlay field option was successfully updated.' }
        format.json { render :show, status: :ok, location: @overlay_field_option }
      else
        format.html { render :edit }
        format.json { render json: @overlay_field_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /overlay_field_options/1
  # DELETE /overlay_field_options/1.json
  def destroy
    @overlay_field_option.destroy
    respond_to do |format|
      format.html { redirect_to overlay_field_options_url, notice: 'Overlay field option was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_overlay_field_option
      @overlay_field_option = OverlayFieldOption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def overlay_field_option_params
      params.require(:overlay_field_option).permit(:overlay_field_id, :name)
    end
end
