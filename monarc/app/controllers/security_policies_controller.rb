class SecurityPoliciesController < ApplicationController
  
  before_action :set_security_policy, only: [:show, :edit, :update, :destroy, 
    :by_version, :dump_me, :dump_by_object, :api_show_object, :api_show_detailed, 
    :api_show_oscal, :api_show_families,:api_show_controls, :api_show_families_all_oscal,
    :api_show_controls_all_oscal ]
    
  # GET /security_policies
  # GET /security_policies.json
  def index
    @q = SecurityPolicy.ransack(params[:q])
    @security_policies  = @q.result.includes(:security_controls, 
                                             :security_control_families).order('id DESC')
  end
  
  # GET /security_policies/dump_all
  def dump_all
    SecurityPolicy.all.destroy_all 
    flash[:success] = "All Security Policies have been erased."
    redirect_to session[:return_to]
  end
  
  def api_index
     @q = SecurityPolicy.ransack(params[:q])
     @security_policies  = @q.result.includes(:security_controls, :security_control_families)
     
     if (@security_policies != nil)
        if (@security_policies.count > 1)
          policies  = [] 
          @security_policies.each do |policy|
            policies   << policy.attributes
          end
          render json: JSON.pretty_generate(policies)
        else
          render json: JSON.pretty_generate(@security_policies.first.attributes)
        end
     else
       render json: JSON.pretty_generate("No results found")
     end
   end
  
   
   
  def api_show_object
    render json: JSON.pretty_generate(@security_policy.show_oscal_with_eid.attributes!)
  end

  def api_show_detailed
    render json: JSON.pretty_generate(@security_policy.show_oscal_detailed_with_eid.attributes!)
  end
  
  def api_show_oscal
    render json: JSON.pretty_generate(@security_policy.show_oscal_detailed.attributes!)
  end
    
  def api_show_families
    families= []
    @security_policy.security_control_families.each do |family|
      families << family.attributes
    #  families << family.show_oscal_with_eid.attributes!
    #  families << family.show_oscal_detailed_with_eid.attributes!
    #  families << family.show_oscal_detailed.attributes!
    end
    render json: JSON.pretty_generate(families)
  end
  
  def api_show_controls
    controls = [] 
    @security_policy.security_controls.each do |control| 
      controls << control.attributes
      #controls << control.show_oscal_with_eid
      #controls << control.show_oscal_detailed_with_eid
      #controls << control.show_oscal_detailed
    end
    render json: JSON.pretty_generate(controls)
    #json_response(@security_policy.security_controls) 
  end
  
  
  def api_commands
      render json: JSON.pretty_generate("No commands yet")
  end
  
  
      
  # GET /security_policies/:id/dump_me
  def dump_me
    
  end
  
  #get /policy/SP800-53/version/3/dump_by_object
  #post /policy/SP800-53/version/3/dump_by_object/:object_name
  def dump_by_object
    
  end
    
  # GET /security_policies/1
  # GET /security_policies/1.json
  def show
  end

  # GET /security_policies/populate
  def populate
  end
  
  def compare
    if params[:version] > params[:with_version]
      @policy1 = SecurityPolicy.includes(security_control_families: 
        :security_controls).where(name: params[:policy_name], version: params[:version]).first 
      @policy2 = SecurityPolicy.where(name: params[:policy_name], version: params[:with_version]).first
    else
      @policy1 = SecurityPolicy.includes(security_control_families: 
        :security_controls).where(name: params[:policy_name], version: params[:with_version]).first
      @policy2 = SecurityPolicy.where(name: params[:policy_name], version: params[:version]).first
    end
    
  end
   
  def by_version
    render 'show'
  end
    
  # GET /security_policies/new
  def new
    @security_policy = SecurityPolicy.new
  end

  # GET /security_policies/1/edit
  def edit
  end

  # POST /security_policies
  # POST /security_policies.json
  def create
    @security_policy = SecurityPolicy.new(security_policy_params)

    respond_to do |format|
      if @security_policy.save
        #json_response(@security_policy, :created)
        format.html {redirect_to @security_policy, notice: 'Security policy was successfully created.'}
        format.json {render :show, status: :created, location: @security_policy}
      else
        format.html {render :new}
        format.json {render json: @security_policy.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /security_policies/1
  # PATCH/PUT /security_policies/1.json
  def update
    respond_to do |format|
      if @security_policy.update(security_policy_params)
        format.html {redirect_to @security_policy, notice: 'Security policy was successfully updated.'}
        format.json {render :show, status: :ok, location: @security_policy}
      else
        format.html {render :edit}
        format.json {render json: @security_policy.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /security_policies/1
  # DELETE /security_policies/1.json
  def destroy
    @security_policy.destroy
    respond_to do |format|
      format.html {redirect_to security_policies_url, notice: 'Security policy was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_security_policy
      if (params[:id] != nil )
          @security_policy = SecurityPolicy.includes(:security_control_families,
                                                     {:security_control_families => :security_controls}).find(params[:id])
      else
          @security_policy = SecurityPolicy.includes(:security_control_families,
                                                     {:security_control_families => :security_controls}).where(name: 
                                                       params[:policy_name], version: params[:version]).first
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def security_policy_params
      params.require(:security_policy).permit(:name, :version, :provider, 
                                              :requirements_id, :security_controls_id, :security_control_families_id, :provider_id)
    end
end
