class SecurityControlFamiliesController < ApplicationController
  before_action :set_security_control_family, only: [:show, :edit,
    :update, :destroy, :add_security_control, :api_show_controls, 
    :api_show_object, :api_show_detailed, :api_show_oscal]

  # GET /security_control_families
  # GET /security_control_families.json
  def index
    @q = SecurityControlFamily.ransack(params[:q])
    @security_control_families  = @q.result.includes(:security_controls,
                                                     :security_policy).page(params[:page]).order('id ASC')
  end

  # GET /security_control_families/dump_all
  def dump_all
    SecurityControlFamily.all.destroy_all 
    flash[:success] = "All Security Control Families have been erased."
    redirect_to session[:return_to]
  end
    
    
  def api_index
    @q = SecurityControlFamily.ransack(params[:q])
    @security_control_families  = @q.result.includes(:security_controls, :security_policy)
    if (@security_control_families != nil)
       if (@security_control_families.count > 1)
         families = []
             @security_control_families.each do |family|
               families  << family.attributes
             end
         render json: JSON.pretty_generate(families)
       else
         render json: JSON.pretty_generate(@security_control_families.first.attributes)
       end
    else
      render json: JSON.pretty_generate("No results found")
    end
  end
  
 
    
  def api_show_object
    
    render json: JSON.pretty_generate(@security_control_family.show_oscal_with_eid.attributes!)
    #json_response(@security_control_family)
  end
  
  def api_show_detailed
    render json: JSON.pretty_generate(@security_control_family.show_oscal_detailed_with_eid.attributes!)
  end
  def api_show_oscal
    render json: JSON.pretty_generate(@security_control_family.show_oscal_detailed.attributes!)
  end
  def api_show_controls
    controls = []
    @security_control_family.security_controls.each do |control|
      controls << control.attributes
    end
    render json: JSON.pretty_generate(controls)
  end
  
  def api_commands
    render json: JSON.pretty_generate("No commands yet")
  end
 
    
  # GET /security_control_families/1
  # GET /security_control_families/1.json
  def show
    @other_security_families = SecurityControlFamily.where(family: @security_control_family.family)\
      .where.not(security_policy_id: @security_control_family.security_policy_id)
  end
  
  def by_family
    family = params[:family]
    family = family.gsub "%20"," "  
    @security_policy = SecurityPolicy.where(name: params[:policy_name], version: params[:version]).first
    @security_control_family = SecurityControlFamily.includes(:security_controls, 
                                                              :security_policy).where(family: family, security_policy: @security_policy).first
    @other_security_families = SecurityControlFamily.where(family: family).where.not(security_policy_id:
      @security_control_family.security_policy_id)
    render 'show'
  end
  
  #I dont like this, but cant send :version twice, so using :id as the 2nd one...
  def compare
    family = params[:family]
    family = family.gsub "%20"," "  
    @security_policy = SecurityPolicy.where(name: params[:policy_name], version: params[:version]).first
    @security_control_family = SecurityControlFamily.includes(:security_controls,
                                                              :security_policy).where(family: family, security_policy: @security_policy).first
    @other_security_families = SecurityControlFamily.where(family: family).where.not(security_policy_id: 
      @security_control_family.security_policy_id)
    @security_policy2 = SecurityPolicy.where(name: params[:policy_name], version: params[:id]).first
    @security_control_family2 = SecurityControlFamily.includes(:security_controls, 
                                                               :security_policy).where(family: family, security_policy: @security_policy2).first
  end
  # GET /security_control_families/new
  def new
    @security_control_family = SecurityControlFamily.new
    if (params[:version] != nil) && (params[:policy_name])
      @security_policy = SecurityPolicy.where(name: params[:policy_name], version: params[:version]).first
    end
  end
  
  def add_security_control
      @security_control = SecurityControl.new
  end
    

  # GET /security_control_families/1/edit
  def edit
  end

  # POST /security_control_families
  # POST /security_control_families.json
  def create
    @security_control_family = SecurityControlFamily.new(security_control_family_params)

    respond_to do |format|
      if @security_control_family.save
        format.html {redirect_to @security_control_family, notice: 'Security control family was successfully created.'}
        format.json {render :show, status: :created, location: @security_control_family}
      else
        format.html {render :new}
        format.json {render json: @security_control_family.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /security_control_families/1
  # PATCH/PUT /security_control_families/1.json
  def update
    respond_to do |format|
      if @security_control_family.update(security_control_family_params)
        format.html {redirect_to @security_control_family, notice: 'Security control family was successfully updated.'}
        format.json {render :show, status: :ok, location: @security_control_family}
      else
        format.html {render :edit}
        format.json {render json: @security_control_family.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /security_control_families/1
  # DELETE /security_control_families/1.json
  def destroy
    @security_control_family.destroy
    respond_to do |format|
      format.html {redirect_to security_control_families_url, notice: 'Security control family was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_security_control_family
      if (params[:policy_name] != nil)
          if (params[:abv] != nil)
            @security_control_family = SecurityControlFamily.includes(:security_controls, 
                                                                      :security_policy).where(abv: params[:abv], security_policy: @security_policy).first
            if (@security_control_family == nil) && (params[:abv].length > 2)
              @security_control_family = SecurityControlFamily.includes(:security_controls,
                                                                        :security_policy).where(family: params[:abv], security_policy: @security_policy).first
            end
          elsif (params[:title] != nil)
            title = params[:title]
            title = title.gsub "%20", " "
            @security_control_family = SecurityControlFamily.includes(:security_controls, 
                                                                      :security_policy).where(family: params[:title], security_policy: @security_policy).first
            if (@security_control_family == nil) && (params[:title].length == 2)
              @security_control_family = SecurityControlFamily.includes(:security_controls, 
                                                                        :security_policy).where(abv: params[:title], security_policy: @security_policy).first
            end
          end
      else
        @security_control_family = SecurityControlFamily.includes(:security_controls, :security_policy).find(params[:id])
        @security_policy = @security_control_family.security_policy          
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def security_control_family_params
      params.require(:security_control_family).permit(:abv, :family, :title, :version, :provider, 
                                                      :security_controls_id, :security_policy_id, :security_policies_id, :family_class)
    end
end
