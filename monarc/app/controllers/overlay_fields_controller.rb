class OverlayFieldsController < ApplicationController
  before_action :set_overlay_field, only: [:show, :edit, :update, :destroy]

  # GET /overlay_fields
  # GET /overlay_fields.json
  def index
    @overlay_fields = OverlayField.all
  end

  # GET /overlay_fields/1
  # GET /overlay_fields/1.json
  def show
  end

  # GET /overlay_fields/new
  def new
    @overlay_field = OverlayField.new
  end

  # GET /overlay_fields/1/edit
  def edit
  end

  # POST /overlay_fields
  # POST /overlay_fields.json
  def create
    @overlay_field = OverlayField.new(overlay_field_params)

    respond_to do |format|
      if @overlay_field.save
        format.html { redirect_to @overlay_field, notice: 'Overlay field was successfully created.' }
        format.json { render :show, status: :created, location: @overlay_field }
      else
        format.html { render :new }
        format.json { render json: @overlay_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /overlay_fields/1
  # PATCH/PUT /overlay_fields/1.json
  def update
    respond_to do |format|
      if @overlay_field.update(overlay_field_params)
        format.html { redirect_to @overlay_field, notice: 'Overlay field was successfully updated.' }
        format.json { render :show, status: :ok, location: @overlay_field }
      else
        format.html { render :edit }
        format.json { render json: @overlay_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /overlay_fields/1
  # DELETE /overlay_fields/1.json
  def destroy
    @overlay_field.destroy
    respond_to do |format|
      format.html { redirect_to overlay_fields_url, notice: 'Overlay field was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_overlay_field
      @overlay_field = OverlayField.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def overlay_field_params
      params.require(:overlay_field).permit(:overlay, :name)
    end
end
