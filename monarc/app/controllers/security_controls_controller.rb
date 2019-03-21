class SecurityControlsController < ApplicationController
  before_action :set_security_control, only: [:edit, :update, :destroy, :add_param,
    :add_statement, :find_by_fields, :add_item, :add_assessment, :add_objective,
    :add_guidance ,  :api_exportJson, :api_show_object, 
    :api_show_detailed, :api_show_oscal]
  
  # GET /security_controls
  # GET /security_controls.json
  def index
    @q = SecurityControl.ransack(params[:q])
    @security_controls = @q.result.includes(:security_policy, 
                                            :security_control_family).order('id ASC')
  end

  # GET /security_controls/dump_all
  def dump_all
    SecurityControl.all.destroy_all 
    flash[:success] = "All Security Controls have been erased."
    redirect_to session[:return_to]
  end
   
  def api_index
    @q = SecurityControl.ransack(params[:q])
    @security_controls = @q.result.includes(:security_policy, :security_control_family)
    if (@security_controls != nil)
        if (@security_controls.count > 1)
          control_array = []
          @security_controls.each do |control|
            control_array << control.attributes
          end   
          render json: JSON.pretty_generate(control_array)
        else
          render json: JSON.pretty_generate(@security_controls.first.attributes)
        end
    else
      render json: JSON.pretty_generate("No results found")
    end
  end
  
  def api_show_object
      render json: JSON.pretty_generate(@security_control.show_oscal_with_eid.attributes!)
  end
    
  def api_show_detailed
    render json: JSON.pretty_generate(@security_control.show_oscal_detailed_with_eid.attributes!)
  end
    
  def api_show_oscal
      render json: JSON.pretty_generate(@security_control.show_oscal_detailed.attributes!)
  end
  
  def api_commands
      render json: JSON.pretty_generate("No commands yet")
  end

  def api_find_by_fields
    render json: JSON.pretty_generate(@security_control.show_oscal_detailed_with_eid.attributes!)
  end
 
  
  
  # GET /security_controls/1
  # GET /security_controls/1.json
  def show
    @security_control = SecurityControl.includes(:assessments, {:assessments => :assessment_objects},
                                                 :guidances, :objectives, :statements, {:statements => :items}, :control_implementations, :control_overlays).find(params[:id])
    @security_control_family = @security_control.security_control_family 
    @security_policy = @security_control_family.security_policy

  end
   
  # GET /security_controls/new
  def new
    @security_control = SecurityControl.new
  end
  
  # GET /security_control/1/add_param
  # POST /security_control/1/add_param
  def add_param
    @param = Param.new
  end
  #POST /policy/:policy_name/version/:version/security_control/:control_id
  #GET /policy/:policy_name/version/:version/security_control/:control_id
  def find_by_fields
    @security_control_family = @security_control.security_control_family 
    render 'show'
  end
  
  def show_full_policy
    @security_policy = SecurityPolicy.where(name: params[:policy_name], version: params[:version]).first
    
    @security_controls = SecurityControl.includes(:assessments, {:assessments => :assessment_objects}, :guidances, 
      :objectives, :statements, {:statements => :items}).where(security_policy_id: @security_policy.id)
  end

  def compare
    @security_policy = SecurityPolicy.where(name: params[:policy_name], version: params[:version]).first
    @security_control = SecurityControl.includes(:assessments, {:assessments => :assessment_objects}, :guidances, 
      :objectives, :statements, {:statements => :items}).where(control_id: params[:control_id], security_policy_id: @security_policy.id).first
    @security_control_family = @security_control.security_control_family
      
    @security_policy2 = SecurityPolicy.where(name: params[:policy_name], version: params[:with_version]).first
    @security_control2 = SecurityControl.includes(:assessments, {:assessments => :assessment_objects}, :guidances,
      :objectives, :statements, {:statements => :items}).where(control_id: params[:control_id], 
                                                                           security_policy_id: @security_policy2.id).first
    @security_control_family2 = @security_control2.security_control_family
      
  end
  
  # GET /security_control/1/add_statement
  # POST /security_control/1/add_statement
  def add_statement
     @statement = Statement.new
  end

  
  
  # GET /security_control/1/add_item
  # POST /security_control/1/add_item
  def add_item
      @item = Item.new
  end
  
  # GET /security_control/1/add_assessment
  # POST /security_control/1/add_assessment
  def add_assessment
      @assessment = Assessment.new
  end
  
  # GET /security_control/1/add_objective
  # POST /security_control/1/add_objective
  def add_objective
      @objective = Objective.new
  end
  
  # GET /security_control/1/add_guidance
  # POST /security_control/1/add_guidance
  def add_guidance
      @guidance= Guidance.new
  end
  
  # GET /security_controls/1/edit
  def edit
  end

  # POST /security_controls
  # POST /security_controls.json
  def create
    @security_control = SecurityControl.new(security_control_params)
    @security_control_family = @security_control.security_control_family
    respond_to do |format|
      if @security_control.save
        format.html { redirect_to @security_control, notice: 'Security control was successfully created.' }
        format.json { render :show, status: :created, location: @security_control }
      else
        format.html { render :new }
        format.json { render json: @security_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /security_controls/1
  # PATCH/PUT /security_controls/1.json
  def update
    respond_to do |format|
      if @security_control.update(security_control_params)
        format.html { redirect_to @security_control, notice: 'Security control was successfully updated.' }
        format.json { render :show, status: :ok, location: @security_control }
      else
        format.html { render :edit }
        format.json { render json: @security_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /security_controls/1
  # DELETE /security_controls/1.json
  def destroy
    @security_control.destroy
    respond_to do |format|
      format.html { redirect_to security_controls_url, notice: 'Security control was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_security_control
        if params[:policy_name] != nil
          @security_policy = SecurityPolicy.where(name: params[:policy_name], version: params[:version]).first
          @security_control = SecurityControl.includes(:assessments, {:assessments => :assessment_objects}, 
                                                       :guidances, :objectives, :statements, {:statements => :items}).where(control_id: 
              params[:control_id], security_policy_id: @security_policy.id).first
        else
          @security_control = SecurityControl.find(params[:id])
          @security_control_family = @security_control.security_control_family 
          @security_policy = @security_control_family.security_policy
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def security_control_params
      params.require(:security_control).permit(:control_id, :security_control_family_id, :title, 
                                               :security_policy_id, :control_class, :status, :security_control_id, :policy_name, :version, :name)
    end
end
