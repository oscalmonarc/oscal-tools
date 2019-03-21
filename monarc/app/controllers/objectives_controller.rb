class ObjectivesController < ApplicationController
  before_action :set_objective, only: [:show, :edit, :update, :destroy, :add_objective, :api_show_object,
    :api_show_detailed, :api_show_oscal]

  # GET /objectives
  # GET /objectives.json
  def index
    @objectives = Objective.all.order('id asc')
  end

  # GET /objectives/1
  # GET /objectives/1.json
  def show
  end

  # GET /objectives/new
  def new
    @objective = Objective.new
  end

  # GET /objectives/1/edit
  def edit
  end

  
  def add_objective
      @new_objective = @objective
  end
  
  def api_index
    @objectives = Objective.all
    objectives = [] 
    @objectives.each do |objective|
      objectives << objective.attributes
    end
    render json: JSON.pretty_generate(objectives)
  end
  
  def api_show_object
      render json: JSON.pretty_generate(@objectives.show_oscal_with_eid.attributes!)
  end
    
  def api_show_detailed
    render json: JSON.pretty_generate(@objectives.show_oscal_detailed_with_eid.attributes!)
  end
    
  def api_show_oscal
      render json: JSON.pretty_generate(@objectives.show_oscal_detailed.attributes!)
  end
  
  def api_commands
      render json: JSON.pretty_generate("No commands yet")
  end
  # POST /objectives
  # POST /objectives.json
  def create
    @objective = Objective.new(objective_params)

    respond_to do |format|
      if @objective.save
        format.html {redirect_to @objective, notice: 'Objective was successfully created.'}
        format.json {render :show, status: :created, location: @objective}
      else
        format.html {render :new}
        format.json {render json: @objective.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /objectives/1
  # PATCH/PUT /objectives/1.json
  def update
    respond_to do |format|
      if @objective.update(objective_params)
        format.html {redirect_to @objective, notice: 'Objective was successfully updated.'}
        format.json {render :show, status: :ok, location: @objective}
      else
        format.html {render :edit}
        format.json {render json: @objective.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /objectives/1
  # DELETE /objectives/1.json
  def destroy
    @objective.destroy
    respond_to do |format|
      format.html {redirect_to objectives_url, notice: 'Objective was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_objective
      @objective = Objective.find(params[:id])
      if (@objective.security_control_id != nil)
          @security_control = @objective.security_control
          @security_control_family = @security_control.security_control_family 
          @security_policy = @security_control_family.security_policy
      end 
      if (@objective.requirement_id != nil)
          @requirement = @objective.requirement
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def objective_params
      params.require(:objective).permit(:parent_id, :objective_id, :name, :description, :security_control_id, :requirement_id)
    end
end
