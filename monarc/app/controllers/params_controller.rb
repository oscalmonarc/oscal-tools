class ParamsController < ApplicationController
  before_action :set_param, only: [:show, :edit, :update, :destroy, 
    :api_show_object, :api_show_detailed, :api_show_oscal]

  # GET /params
  # GET /params.json
  def index
    @params = Param.all.paginate(:page => params[:page]).order('id asc')
  end

  # GET /params/1
  # GET /params/1.json
  def show
  end

  # GET /params/new
  def new
    @param = Param.new
  end

  # GET /params/1/edit
  def edit
  end

  
  def api_index
    @params = Param.all
    params = [] 
    @params.each do |param|
      params << param.attributes
    end
    render json: JSON.pretty_generate(params)
  end
  
  def api_show_object
      render json: JSON.pretty_generate(@params.show_oscal_with_eid.attributes!)
  end
    
  def api_show_detailed
    render json: JSON.pretty_generate(@params.show_oscal_detailed_with_eid.attributes!)
  end
    
  def api_show_oscal
      render json: JSON.pretty_generate(@params.show_oscal_detailed.attributes!)
  end
  
  def api_commands
      render json: JSON.pretty_generate("No commands yet")
  end

  # POST /params
  # POST /params.json
  def create
    @param = Param.new(param_params)

    respond_to do |format|
      if @param.save
        format.html {redirect_to @param, notice: 'Param was successfully created.'}
        format.json {render :show, status: :created, location: @param}
      else
        format.html {render :new}
        format.json {render json: @param.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /params/1
  # PATCH/PUT /params/1.json
  def update
    respond_to do |format|
      if @param.update(param_params)
        format.html {redirect_to @param, notice: 'Param was successfully updated.'}
        format.json {render :show, status: :ok, location: @param}
      else
        format.html {render :edit}
        format.json {render json: @param.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /params/1
  # DELETE /params/1.json
  def destroy
    @param.destroy
    respond_to do |format|
      format.html {redirect_to params_url, notice: 'Param was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_param
      @param = Param.find(params[:id])
      if (@param.security_control_id != nil)
          @security_control = @param.security_control
          @security_control_family = @security_control.security_control_family 
          @security_policy = @security_control_family.security_policy

      end 
      #if (@param.requirement_id != nil)
      #    @requirement = @guidance.requirement
      #end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def param_params
      params.require(:param).permit(:params_id, :label, :info, :security_control_id, 
                                    :statement_id, :item_id, :depends_on_id, :parent_id, :description, :selection_type )
    end
end
