class ParamValuesController < ApplicationController
  before_action :set_param_value, only: [:show, :edit, :update, :destroy]

  # GET /param_values
  # GET /param_values.json
  def index
    @param_values = ParamValue.all.paginate(:page => params[:page]).order('id asc')
  end

  # GET /param_values/1
  # GET /param_values/1.json
  def show
  end

  # GET /param_values/new
  def new
    @param_value = ParamValue.new
    @param = Param.find(params[:param_id])
    @param_value.param_id = @param.id
    
    if(@param.security_control != nil)
      @security_control = @param.security_control  
      @security_control_family = @security_control.security_control_family  
    end

  end

  # GET /param_values/1/edit
  def edit
  end

  # POST /param_values
  # POST /param_values.json
  def create
    @param_value = ParamValue.new(param_value_params)

    respond_to do |format|
      if @param_value.save
        format.html {redirect_to @param_value, notice: 'Param value was successfully created.'}
        format.json {render :show, status: :created, location: @param_value}
      else
        @param = Param.find(@param_value.param_id)
        @security_control = @param.security_control  
        @security_control_family = @security_control.security_control_family  

        format.html {render :new}
        format.json {render json: @param_value.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /param_values/1
  # PATCH/PUT /param_values/1.json
  def update
    respond_to do |format|
      if @param_value.update(param_value_params)
        format.html {redirect_to @param_value, notice: 'Param value was successfully updated.'}
        format.json {render :show, status: :ok, location: @param_value}
      else
        format.html {render :edit}
        format.json {render json: @param_value.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /param_values/1
  # DELETE /param_values/1.json
  def destroy
    @param_value.destroy
    respond_to do |format|
      format.html {redirect_to param_values_url, notice: 'Param value was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_param_value
      @param_value = ParamValue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def param_value_params
      params.require(:param_value).permit(:param_id, :param_value_id, :the_value)
    end
end
