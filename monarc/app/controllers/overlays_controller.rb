class OverlaysController < ApplicationController
  before_action :set_overlay, only: [:show, :edit, :update, :destroy]

  # GET /overlays
  # GET /overlays.json
  def index
    @overlays = Overlay.all
  end

  # GET /overlays/1
  # GET /overlays/1.json
  def show
  end
  
  # GET /overlays/dump_all
  def dump_all
    Overlay.all.destroy_all 
    flash[:success] = "All Overlays have been erased."
    redirect_to session[:return_to]
  end
    
  # GET /overlays/new
  def new
    @overlay = Overlay.new
  end

  # GET /overlays/1/edit
  def edit
  end
  
  def find_baseline
      @full_list = []
      @conf = nil
      @integ = nil
      @avail = nil
      @overlay_selected = nil
    
      @security_policies_array = SecurityPolicy.all.map { |policy| [policy.policy_version , policy.id] }
      if(params[:overlay] != nil)
        @policy = params[:overlay][:policy]
      else
        @policy= @security_policies_array.first[1]
      end
      @overlays = Overlay.includes(overlay_fields: :overlay_field_options)
      @selected_options  = []
     
       @nss_option = true
       if (params[:overlay] != nil) && (params[:overlay][:nss] != nil)
          if (params[:overlay][:nss] == "0")
            @nss_option = false
          else
            @nss_option = true
          end
       end
  end
  def compare_overlays
    @full_list = []
    @conf = nil
    @integ = nil
    @avail = nil
    @overlay_selected = nil
    
  
    @security_policies_array = SecurityPolicy.all.map { |policy| [policy.policy_version , policy.id] }
    if(params[:overlay] != nil)
      puts "setting policies"
      @policy1 = params[:overlay][:policy_1]
      @policy2 = params[:overlay][:policy_2]
    else
      @policy1 = @security_policies_array.first[1]
      @policy2 = @security_policies_array.second[1]
    end
    @overlays = Overlay.includes(overlay_fields: :overlay_field_options)
    @selected_options1 = []
    @selected_options2 = []
    @nss_option = true
      if (params[:overlay] != nil) && (params[:overlay][:nss] != nil)
         if (params[:overlay][:nss] == "0")
           @nss_option = false
         else
           @nss_option = true
         end
      end
  end
    
    
  # POST /overlays
  # POST /overlays.json
  def create
    @overlay = Overlay.new(overlay_params)

    respond_to do |format|
      if @overlay.save
        format.html { redirect_to @overlay, notice: 'Overlay was successfully created.' }
        format.json { render :show, status: :created, location: @overlay }
      else
        format.html { render :new }
        format.json { render json: @overlay.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /overlays/1
  # PATCH/PUT /overlays/1.json
  def update
    respond_to do |format|
      if @overlay.update(overlay_params)
        format.html { redirect_to @overlay, notice: 'Overlay was successfully updated.' }
        format.json { render :show, status: :ok, location: @overlay }
      else
        format.html { render :edit }
        format.json { render json: @overlay.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /overlays/1
  # DELETE /overlays/1.json
  def destroy
    @overlay.destroy
    respond_to do |format|
      format.html { redirect_to overlays_url, notice: 'Overlay was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_overlay
    @overlay = Overlay.includes(:overlay_fields, {overlay_fields: :overlay_field_options}, :control_overlays).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def overlay_params
      params.require(:overlay).permit(:provider_id, :name)
    end
end
