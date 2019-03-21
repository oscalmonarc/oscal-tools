class ComponentDomainsController < ApplicationController
  before_action :set_component_domain, only: [:show, :edit, :update, :destroy]

  # GET /component_domains
  # GET /component_domains.json
  def index
    @component_domains = ComponentDomain.all
  end

  # GET /component_domains/1
  # GET /component_domains/1.json
  def show
  end

  # GET /component_domains/new
  def new
    @component_domain = ComponentDomain.new
  end

  # GET /component_domains/1/edit
  def edit
  end

  # POST /component_domains
  # POST /component_domains.json
  def create
    @component_domain = ComponentDomain.new(component_domain_params)

    respond_to do |format|
      if @component_domain.save
        format.html { redirect_to @component_domain, notice: 'Component domain was successfully created.' }
        format.json { render :show, status: :created, location: @component_domain }
      else
        format.html { render :new }
        format.json { render json: @component_domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /component_domains/1
  # PATCH/PUT /component_domains/1.json
  def update
    respond_to do |format|
      if @component_domain.update(component_domain_params)
        format.html { redirect_to @component_domain, notice: 'Component domain was successfully updated.' }
        format.json { render :show, status: :ok, location: @component_domain }
      else
        format.html { render :edit }
        format.json { render json: @component_domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /component_domains/1
  # DELETE /component_domains/1.json
  def destroy
    @component_domain.destroy
    respond_to do |format|
      format.html { redirect_to component_domains_url, notice: 'Component domain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component_domain
      @component_domain = ComponentDomain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def component_domain_params
      params.require(:component_domain).permit(:component_id, :domain_environment_id)
    end
end
