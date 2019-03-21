class DomainEnvironmentsController < ApplicationController
  before_action :set_domain_environment, only: [:show, :edit, :update, :destroy]

  # GET /domain_environments
  # GET /domain_environments.json
  def index
    @domain_environments = DomainEnvironment.all
  end

  # GET /domain_environments/1
  # GET /domain_environments/1.json
  def show
  end

  # GET /domain_environments/dump_all
  def dump_all
    DomainEnvironment.all.destroy_all 
    flash[:success] = "All Domain Environments have been erased."
    redirect_to session[:return_to]
  end
    
  # GET /domain_environments/new
  def new
    @domain_environment = DomainEnvironment.new
  end

  # GET /domain_environments/1/edit
  def edit
  end

  # POST /domain_environments
  # POST /domain_environments.json
  def create
    @domain_environment = DomainEnvironment.new(domain_environment_params)
    
    respond_to do |format|
      if @domain_environment.save
        format.html {redirect_to @domain_environment, notice: 'Domain environment was successfully created.'}
        format.json {render :show, status: :created, location: @domain_environment}
      else
        format.html {render :new}
        format.json {render json: @domain_environment.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /domain_environments/1
  # PATCH/PUT /domain_environments/1.json
  def update
    respond_to do |format|
      if @domain_environment.update(domain_environment_params)
        format.html {redirect_to @domain_environment, notice: 'Domain environment was successfully updated.'}
        format.json {render :show, status: :ok, location: @domain_environment}
      else
        format.html {render :edit}
        format.json {render json: @domain_environment.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /domain_environments/1
  # DELETE /domain_environments/1.json
  def destroy
    @domain_environment.destroy
    respond_to do |format|
      format.html {redirect_to domain_environments_url, notice: 'Domain environment was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domain_environment
      @domain_environment = DomainEnvironment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domain_environment_params
      params.require(:domain_environment).permit(:name, :description, :data_classification,
                                                 :provideranization_id, :parent_id, :parent, :data_classification_id, :data_classification, 
                                                 :provider_id, :region)
    end
end
