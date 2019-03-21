class GuidancesController < ApplicationController
  before_action :set_guidance, only: [:show, :edit, :update, :destroy, 
    :api_show_object, :api_show_detailed, :api_show_oscal]

  # GET /guidances
  # GET /guidances.json
  def index
    @guidances = Guidance.all.paginate(:page => params[:page]).order('id asc')
  end

  # GET /guidances/1
  # GET /guidances/1.json
  def show
  end

  # GET /guidances/new
  def new
    @guidance = Guidance.new
  end

  # GET /guidances/1/edit
  def edit
  end

  
  def api_index
    @guidance = Guidance.all
    guidances  = [] 
    @guidance.each do |guidance|
      guidances << guidance.attributes
    end
    render json: JSON.pretty_generate(guidances)
  end
  
  def api_show_object
      render json: JSON.pretty_generate(@guidance.show_oscal_with_eid.attributes!)
  end
    
  def api_show_detailed
    render json: JSON.pretty_generate(@guidance.show_oscal_detailed_with_eid.attributes!)
  end
    
  def api_show_oscal
      render json: JSON.pretty_generate(@guidance.show_oscal_detailed.attributes!)
  end
  
  def api_commands
      render json: JSON.pretty_generate("No commands yet")
  end
  # POST /guidances
  # POST /guidances.json
  def create
    @guidance = Guidance.new(guidance_params)

    respond_to do |format|
      if @guidance.save
        format.html {redirect_to @guidance, notice: 'Guidance was successfully created.'}
        format.json {render :show, status: :created, location: @guidance}
      else
        format.html {render :new}
        format.json {render json: @guidance.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /guidances/1
  # PATCH/PUT /guidances/1.json
  def update
    respond_to do |format|
      if @guidance.update(guidance_params)
        format.html {redirect_to @guidance, notice: 'Guidance was successfully updated.'}
        format.json {render :show, status: :ok, location: @guidance}
      else
        format.html {render :edit}
        format.json {render json: @guidance.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /guidances/1
  # DELETE /guidances/1.json
  def destroy
    @guidance.destroy
    respond_to do |format|
      format.html {redirect_to guidances_url, notice: 'Guidance was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_guidance
      @guidance = Guidance.find(params[:id])
      if (@guidance.security_control_id != nil)
          @security_control = @guidance.security_control
          @security_control_family = @security_control.security_control_family 
          @security_policy = @security_control_family.security_policy
      end 
      if (@guidance.requirement_id != nil)
          @requirement = @guidance.requirement
          @security_policy = @requirement.security_policy
      end 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guidance_params
      params.require(:guidance).permit(:guidance_id, :description, :security_control_id, :requirement_id)
    end
end
