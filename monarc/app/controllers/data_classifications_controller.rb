class DataClassificationsController < ApplicationController
  before_action :set_data_classification, only: [:show, :edit, :update, :destroy]

  # GET /data_classifications
  # GET /data_classifications.json
  def index
    @data_classifications = DataClassification.all
  end

  # GET /data_classifications/1
  # GET /data_classifications/1.json
  def show
  end

  # GET /data_classifications/dump_all
  def dump_all
    DataClassification.all.destroy_all 
    flash[:success] = "All Data Classifications have been erased."
    redirect_to session[:return_to]
  end
    
  # GET /data_classifications/new
  def new
    @data_classification = DataClassification.new
  end

  # GET /data_classifications/1/edit
  def edit
  end

  # POST /data_classifications
  # POST /data_classifications.json
  def create
    @data_classification = DataClassification.new(data_classification_params)

    respond_to do |format|
      if @data_classification.save
        format.html {redirect_to @data_classification, notice: 'Data classification was successfully created.'}
        format.json {render :show, status: :created, location: @data_classification}
      else
        format.html {render :new}
        format.json {render json: @data_classification.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /data_classifications/1
  # PATCH/PUT /data_classifications/1.json
  def update
    respond_to do |format|
      if @data_classification.update(data_classification_params)
        format.html {redirect_to @data_classification, notice: 'Data classification was successfully updated.'}
        format.json {render :show, status: :ok, location: @data_classification}
      else
        format.html {render :edit}
        format.json {render json: @data_classification.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /data_classifications/1
  # DELETE /data_classifications/1.json
  def destroy
    @data_classification.destroy
    respond_to do |format|
      format.html {redirect_to data_classifications_url, notice: 'Data classification was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_data_classification
      @data_classification = DataClassification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def data_classification_params
      params.require(:data_classification).permit(:name)
    end
end
