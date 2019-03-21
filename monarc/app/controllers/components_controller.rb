class ComponentsController < ApplicationController
  before_action :set_component, only: [:show, :edit, :update, :destroy, :add_implementation]

  # GET /components
  # GET /components.json
  def index
    @components = Component.all
  end

  # GET /components/dump_all
  def dump_all
    Component.all.destroy_all 
    flash[:success] = "All Components have been erased."
    redirect_to session[:return_to]
  end
    
  # GET /components/1
  # GET /components/1.json
  def show
  end
  
  def add_child_component
    @parent_component = Component.includes(:component_domains, {component_domains: :domain_environments}, :control_implementations, {control_implementations: :security_control}).find(params[:id])
    @component = Component.new
    render "new"
  end
  
  # GET /components/new
  def new
    @component = Component.new
  end

  # GET /components/1/edit
  def edit
  end

  # POST /components
  # POST /components.json
  def create
    @component = Component.new(component_params)

    respond_to do |format|
      if @component.save
        format.html { redirect_to @component, notice: 'Component was successfully created.' }
        format.json { render :show, status: :created, location: @component }
      else
        format.html { render :new }
        format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /components/1
  # PATCH/PUT /components/1.json
  def update
    respond_to do |format|
      if @component.update(component_params)
        format.html { redirect_to @component, notice: 'Component was successfully updated.' }
        format.json { render :show, status: :ok, location: @component }
      else
        format.html { render :edit }
        format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /components/1
  # DELETE /components/1.json
  def destroy
    @component.destroy
    respond_to do |format|
      format.html { redirect_to components_url, notice: 'Component was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component
    @component = Component.includes(:component_domains, {component_domains: :domain_environments}, :control_implementations, {control_implementations: :security_control}).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def component_params
      params.require(:component).permit(:provider_id, :name, :description, :make, :model, :version, :label, :parent_id)
    end
end
