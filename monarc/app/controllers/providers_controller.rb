class ProvidersController < ApplicationController
  before_action :set_provider, only: [:show, :edit, :update, :destroy]

  # GET /providers
  # GET /providers.json
  def index
    @providers = Provider.includes(:domain_environments, :components, :related_labels, {related_labels: :label}).all
  end

  # GET /providers/1
  # GET /providers/1.json
  def show
  end
  
  # GET /providers/dump_all
  def dump_all
    Provider.all.destroy_all 
    flash[:success] = "All Providers have been erased."
    redirect_to session[:return_to]
  end
  

  # GET /providers/new
  def new
    @provider = Provider.new
  end

  # GET /providers/1/edit
  def edit
  end

  # POST /providers
  # POST /providers.json
  def create
    @provider = Provider.new(provider_params)

    respond_to do |format|
      if @provider.save
        format.html {redirect_to @provider, notice: 'Provider was successfully created.'}
        format.json {render :show, status: :created, location: @provider}
      else
        format.html {render :new}
        format.json {render json: @provider.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /providers/1
  # PATCH/PUT /providers/1.json
  def update
    respond_to do |format|
      if @provider.update(provider_params)
        format.html {redirect_to @provider, notice: 'Provider was successfully updated.'}
        format.json {render :show, status: :ok, location: @provider}
      else
        format.html {render :edit}
        format.json {render json: @provider.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /providers/1
  # DELETE /providers/1.json
  def destroy
    @provider.destroy
    respond_to do |format|
      format.html {redirect_to providers_url, notice: 'Provider was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_provider
      if (params[:name] != nil)
        
        puts "params[:name] - #{params[:name]}"
        @provider = Provider.includes(:domain_environments, :components, :related_labels,{related_labels: :label}).where(name: params[:name]).first
          puts "@provider #{@provider.name}"
      else
        @provider = Provider.includes(:domain_environments, :components, :related_labels, {related_labels: :label}).find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def provider_params
      params.require(:provider).permit(:name, :location, :description, :org_type, :parent_id)
    end
end
