class AssessmentsController < ApplicationController
  before_action :set_assessment, only: [:show, :edit, :update, :destroy, 
    :add_assessment_object, :api_show_object,
    :api_show_detailed, :api_show_oscal]

  # GET /assessments
  # GET /assessments.json
  def index
    @assessments = Assessment.includes(:security_control).all.paginate(:page => params[:page]).order('id asc')
  end

  # GET /assessments/1
  # GET /assessments/1.json
  def show
  end

  # GET /assessments/new
  def new
    @assessment = Assessment.new
  end

  # GET /assessments/1/edit
  def edit
  end
  
  def add_assessment_object
    @assessment_object = AssessmentObject.new
  end

  
  def api_index
    @assessment = Assessment.all
    assessments  = [] 
    @assessment.each do |assessment|
      assessments << assessment.attributes
    end
    render json: JSON.pretty_generate(assessments)
  end
  
  def api_show_object
      render json: JSON.pretty_generate(@assessment.show_oscal_with_eid.attributes!)
  end
    
  def api_show_detailed
    render json: JSON.pretty_generate(@assessment.show_oscal_detailed_with_eid.attributes!)
  end
    
  def api_show_oscal
      render json: JSON.pretty_generate(@assessment.show_oscal_detailed.attributes!)
  end
  
  def api_commands
      render json: JSON.pretty_generate("No commands yet")
  end
    
  # POST /assessments
  # POST /assessments.json
  def create
    @assessment = Assessment.new(assessment_params)

    respond_to do |format|
      if @assessment.save
        format.html {redirect_to @assessment, notice: 'Assessment was successfully created.'}
        format.json {render :show, status: :created, location: @assessment}
      else
        format.html {render :new}
        format.json {render json: @assessment.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /assessments/1
  # PATCH/PUT /assessments/1.json
  def update
    respond_to do |format|
      if @assessment.update(assessment_params)
        format.html {redirect_to @assessment, notice: 'Assessment was successfully updated.'}
        format.json {render :show, status: :ok, location: @assessment}
      else
        format.html {render :edit}
        format.json {render json: @assessment.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /assessments/1
  # DELETE /assessments/1.json
  def destroy
    @assessment.destroy
    respond_to do |format|
      format.html {redirect_to assessments_url, notice: 'Assessment was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assessment
      @assessment = Assessment.find(params[:id])
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
    def assessment_params
      params.require(:assessment).permit(:method, :security_control_id, :requirement_id, :assessment_id)
    end
end
