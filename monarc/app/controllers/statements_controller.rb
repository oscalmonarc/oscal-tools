class StatementsController < ApplicationController
  before_action :set_statement, only: [:show, :edit, :update, :destroy, :add_param, :add_item,  
    :api_show_object, :api_show_detailed, :api_show_oscal]

  # GET /statements
  # GET /statements.json
  def index
    @statements = Statement.order('id DESC')
  end

  # GET /statements/1
  # GET /statements/1.json
  def show
  end
 
  def api_index
    @statements = Statement.includes(:items).all
    statements  = [] 
    @statements.each do |statement|
      statements   << statement.attributes
    end
    render json: JSON.pretty_generate(statements)
    
  end
  
  def api_show_object
    render json: JSON.pretty_generate(@statements.show_oscal_with_eid.attributes!)
  end
  
  def api_show_detailed
    render json: JSON.pretty_generate(@statements.show_oscal_detailed_with_eid.attributes!)
  end
  
  def api_show_oscal
    render json: JSON.pretty_generate(@statements.show_oscal_detailed.attributes!)
  end
  
  def api_commands
      render json: JSON.pretty_generate("No commands yet")
  end

  # GET /statements/new
  def new
    @statement = Statement.new
  end
  
  def add_param
    @param = Param.new
  end
  
  def add_item
    @item = Item.new
  end

  
  # GET /statements/1/edit
  def edit
  end

  # POST /statements
  # POST /statements.json
  def create
    @statement = Statement.new(statement_params)

    respond_to do |format|
      if @statement.save
        format.html {redirect_to @statement, notice: 'Statement was successfully created.'}
        format.json {render :show, status: :created, location: @statement}
      else
        format.html {render :new}
        format.json {render json: @statement.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /statements/1
  # PATCH/PUT /statements/1.json
  def update
    respond_to do |format|
      if @statement.update(statement_params)
        format.html {redirect_to @statement, notice: 'Statement was successfully updated.'}
        format.json {render :show, status: :ok, location: @statement}
      else
        format.html {render :edit}
        format.json {render json: @statement.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /statements/1
  # DELETE /statements/1.json
  def destroy
    @statement.destroy
    respond_to do |format|
      format.html {redirect_to statements_url, notice: 'Statement was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_statement
      @statement = Statement.find(params[:id])
       if (@statement.security_control_id != nil)
          @security_control = @statement.security_control
       end 
       if (@statement.requirement_id != nil)
           @requirement = @statement.requirement
       end 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def statement_params
      params.require(:statement).permit(:description, :security_control_id, :requirement_id, :parent_id, :statement_id)
    end
end
