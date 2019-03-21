class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :add_item, 
    :api_show_object, :api_show_detailed, :api_show_oscal]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all.order('id asc')
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end
  def api_index
    @items = Item.all
    items = [] 
    @items.each do |item|
      items << item.attributes
    end
    render json: JSON.pretty_generate(items)
  end
  
  def api_show_object
      render json: JSON.pretty_generate(@items.show_oscal_with_eid.attributes!)
  end
    
  def api_show_detailed
    render json: JSON.pretty_generate(@items.show_oscal_detailed_with_eid.attributes!)
  end
    
  def api_show_oscal
      render json: JSON.pretty_generate(@items.show_oscal_detailed.attributes!)
  end
  
  def api_commands
      render json: JSON.pretty_generate("No commands yet")
  end

  
  # GET /items/new
  def new
    @item = Item.new
  end
  
  def add_item
    @new_item = @item
  end

  

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html {redirect_to @item, notice: 'Item was successfully created.'}
        format.json {render :show, status: :created, location: @item}
      else
        format.html {render :new}
        format.json {render json: @item.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html {redirect_to @item, notice: 'Item was successfully updated.'}
        format.json {render :show, status: :ok, location: @item}
      else
        format.html {render :edit}
        format.json {render json: @item.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html {redirect_to items_url, notice: 'Item was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
      @security_control = @item.statement.security_control
      @security_control_family = @security_control.security_control_family 
      @security_policy = @security_control_family.security_policy

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:parent_id, :description, :name, :statement_id, :item_id)
    end
end
