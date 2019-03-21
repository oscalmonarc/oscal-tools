class ControlOverlaysController < ApplicationController
  before_action :set_control_overlay, only: [:show, :edit, :update, :destroy]

  # GET /control_overlays
  # GET /control_overlays.json
  def index
    @control_overlays = ControlOverlay.all
  end

  # GET /control_overlays/1
  # GET /control_overlays/1.json
  def show
  end

  # GET /control_overlays/dump_all
  def dump_all
    ControlOverlay.all.destroy_all 
    flash[:success] = "All Control Overlays have been erased."
    redirect_to session[:return_to]
  end

    
  # GET /control_overlays/new
  def new
    @control_overlay = ControlOverlay.new
  end

  # GET /control_overlays/1/edit
  def edit
  end

  # POST /control_overlays
  # POST /control_overlays.json
  def create
    @control_overlay = ControlOverlay.new(control_overlay_params)

    respond_to do |format|
      if @control_overlay.save
        format.html { redirect_to @control_overlay, notice: 'Control overlay was successfully created.' }
        format.json { render :show, status: :created, location: @control_overlay }
      else
        format.html { render :new }
        format.json { render json: @control_overlay.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /control_overlays/1
  # PATCH/PUT /control_overlays/1.json
  def update
    respond_to do |format|
      if @control_overlay.update(control_overlay_params)
        format.html { redirect_to @control_overlay, notice: 'Control overlay was successfully updated.' }
        format.json { render :show, status: :ok, location: @control_overlay }
      else
        format.html { render :edit }
        format.json { render json: @control_overlay.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /control_overlays/1
  # DELETE /control_overlays/1.json
  def destroy
    @control_overlay.destroy
    respond_to do |format|
      format.html { redirect_to control_overlays_url, notice: 'Control overlay was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_control_overlay
      @control_overlay = ControlOverlay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def control_overlay_params
      params.require(:control_overlay).permit(:security_policy_id, :domain_environment_id, :overlay_field_id, :overlay_value, :security_control_id)
    end
end
