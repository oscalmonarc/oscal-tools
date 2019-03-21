class RelatedLabelsController < ApplicationController
  before_action :set_related_label, only: [:show, :edit, :update, :destroy]

  # GET /related_labels
  # GET /related_labels.json
  def index
    @related_labels = RelatedLabel.all
  end

  # GET /related_labels/1
  # GET /related_labels/1.json
  def show
  end

  # GET /related_labels/new
  def new
    @related_label = RelatedLabel.new
  end

  # GET /related_labels/1/edit
  def edit
  end

  # GET /related_labels/add_to/<object_id>/<object_name>/
   def add_to
     object_id = params[:object_id]
     object_type = params[:object_type]
     puts "object_type #{object_type}, object_id  #{object_id}" 
     @related_label = RelatedLabel.new
       
     @the_object = @related_label.grab_object(object_id, object_type)
     @related_label.object_type = @the_object.class
     @related_label.object_id = @the_object.id
     @related_label.provider_id = @the_object.provider_id 
     
     
   end
   
  # POST /related_labels
  # POST /related_labels.json
  def create
    @related_label = RelatedLabel.new(related_label_params)

    respond_to do |format|
      if @related_label.save
        format.html { redirect_to @related_label, notice: 'Related label was successfully created.' }
        format.json { render :show, status: :created, location: @related_label }
      else
        format.html { render :new }
        format.json { render json: @related_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /related_labels/1
  # PATCH/PUT /related_labels/1.json
  def update
    respond_to do |format|
      if @related_label.update(related_label_params)
        format.html { redirect_to @related_label, notice: 'Related label was successfully updated.' }
        format.json { render :show, status: :ok, location: @related_label }
      else
        format.html { render :edit }
        format.json { render json: @related_label.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /related_labels/1
  # DELETE /related_labels/1.json
  def destroy
    @related_label.destroy
    respond_to do |format|
      format.html { redirect_to session[:return_to], notice: 'Related label was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_related_label
      @related_label = RelatedLabel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def related_label_params
      params.require(:related_label).permit(:label_id, :object_type, :object_id, :provider_id)
    end
end
