class ControlImplementationsController < ApplicationController
  before_action :set_control_implementation, only: [:show, :edit, :update, :destroy]

  # GET /control_implementations
  # GET /control_implementations.json
  def index
    @control_implementations = ControlImplementation.includes(:security_control, :security_policy, :statement, :provider,
      :domain_environment).group_by{ |c| [c.implementation_method, c.security_control, c.security_policy, 
        c.component, c.provider, c.inheritance_type, c.required, c.objective_link, c.statement]}
    
    
    #  @methods = ControlImplementation.unique_control_implementations(@control_implementations)
    @methods = []
    #@control_implementation = nil
    @control_implementation = @control_implementations
    @all_providers = []
    @all_components = []
    @all_domains = []
    if has_data?(@control_implementation)
        @control_implementation.each do |implementations|
    
          
          domains = implementations[1].map{|t| t.domain_environment_click_link}.uniq.join(",")
          @all_providers = @all_providers +  implementations[1].map{|t| t.provider}.uniq
          @all_domains = @all_domains +  implementations[1].map{|t| t.domain_environment}.uniq
          @all_components = @all_components + implementations[1].map{|t| t.component}.uniq
          
          check_method = {component: implementations[0][3].click_link,
                security_control: implementations[0][1].click_link,     
                security_policy: implementations[0][2].click_link,
                provider: implementations[0][4].click_link,
                objective: implementations[0][7],
                statement: implementations[0][8],
                domain_environment: domains,
                inheritance_type: implementations[0][5],  
                implementation_method: implementations[0][0],      
                required: implementations[0][6]}
               @methods << check_method 
        end
        @all_components = @all_components.uniq.reject{ |t| t.nil? }
        
        @all_domains = @all_domains.uniq.reject { |t| t.nil? }
        @all_providers = @all_providers.uniq.reject{ |t| t.nil? }
        
    end            
    @methods = @methods.sort_by {|obj| obj[:security_control]}
  end

  # GET /control_implementations/1
  # GET /control_implementations/1.json
  def show
  end
  
  # GET /control_implementations/dump_all
  def dump_all
    ControlImplementation.all.destroy_all
    flash[:success] = "All Control Implementations have been erased." 
    redirect_to session.delete(:return_to)
  end
  
  
  # GET /control_implementations/new
  def new
    @control_implementation = ControlImplementation.new
    
  end

  # GET /control_implementations/1/edit
  def edit
  end

  # POST /control_implementations
  # POST /control_implementations.json
  def create
    @control_implementation = ControlImplementation.new(control_implementation_params)

    respond_to do |format|
      if @control_implementation.save
        format.html { redirect_to @control_implementation, notice: 'Control implementation was successfully created.' }
        format.json { render :show, status: :created, location: @control_implementation }
      else
        format.html { render :new }
        format.json { render json: @control_implementation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /control_implementations/1
  # PATCH/PUT /control_implementations/1.json
  def update
    respond_to do |format|
      if @control_implementation.update(control_implementation_params)
        format.html { redirect_to @control_implementation, notice: 'Control implementation was successfully updated.' }
        format.json { render :show, status: :ok, location: @control_implementation }
      else
        format.html { render :edit }
        format.json { render json: @control_implementation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /control_implementations/1
  # DELETE /control_implementations/1.json
  def destroy
    @control_implementation.destroy
    respond_to do |format|
      format.html { redirect_to control_implementations_url, notice: 'Control implementation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_control_implementation
      @control_implementation = ControlImplementation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def control_implementation_params
      params.require(:control_implementation).permit(:component_id, :domain_environment_id, :provider_id, :security_control_id, :security_policy_id, :inheritance_type, :implementation_method, :required, :objective_id, :statement_id, :item_id)
    end
end
