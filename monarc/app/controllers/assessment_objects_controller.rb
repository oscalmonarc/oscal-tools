class AssessmentObjectsController < ApplicationController
  before_action :set_assessment_object, only: [:show, :edit, :update, :destroy, 
    :api_show_object, :api_show_detailed]

  # GET /assessment_objects
  # GET /assessment_objects.json
  def index
    @assessment_objects = AssessmentObject.includes(:assessment, {:assessment => 
      :security_control}).all.paginate(:page => params[:page]).order('id asc')
  end
  
  # GET /assessment_objects/dump_all
  def dump_all
    AssessmentObject.all.destroy_all 
    flash[:success] = "All Assessment Objects have been erased."
    redirect_to session[:return_to]
  end
  
  # GET /assessment_objects/1
  # GET /assessment_objects/1.json
  def show
  end

  # GET /assessment_objects/new
  def new
    @assessment_object = AssessmentObject.new
  end

  # GET /assessment_objects/1/edit
  def edit
  end


  # POST /assessment_objects
  # POST /assessment_objects.json
  def create
    @assessment_object = AssessmentObject.new(assessment_object_params)

    respond_to do |format|
      if @assessment_object.save
        format.html {redirect_to @assessment_object.assessment, notice: 'Assessment object was successfully created.'}
        format.json {render :show, status: :created, location: @assessment_object}
      else
        format.html {render :new}
        format.json {render json: @assessment_object.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /assessment_objects/1
  # PATCH/PUT /assessment_objects/1.json
  def update
    respond_to do |format|
      if @assessment_object.update(assessment_object_params)
        format.html {redirect_to @assessment_object, notice: 'Assessment object was successfully updated.'}
        format.json {render :show, status: :ok, location: @assessment_object}
      else
        format.html {render :edit}
        format.json {render json: @assessment_object.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /assessment_objects/1
  # DELETE /assessment_objects/1.json
  def destroy
    @assessment_object.destroy
    respond_to do |format|
      format.html {redirect_to assessment_objects_url, notice: 'Assessment object was successfully destroyed.'}
      format.json {head :no_content}
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment_object
      @assessment_object = AssessmentObject.find(params[:id])
      @assessment = @assessment_object.assessment
      if (@assessment.security_control_id != nil)
          @security_control = @assessment.security_control
          @security_control_family = @security_control.security_control_family 
          @security_policy = @security_control_family.security_policy
      end 
      if (@assessment.requirement_id != nil)
          @requirement = @assessment.requirement
          @security_policy = @requirement.security_policy
      end 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assessment_object_params
      params.require(:assessment_object).permit(:description, :security_control_id, :requirement_id, :assessment_id, :assessment_object_id)
    end
end
