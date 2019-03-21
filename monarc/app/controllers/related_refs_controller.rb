class RelatedRefsController < ApplicationController
  before_action :set_related_ref, only: [:show, :edit, :update, :destroy]

  # GET /related_refs
  # GET /related_refs.json
  def index
    @related_refs = RelatedRef.all.paginate(:page => params[:page]).order('id asc')
  end

  # GET /related_refs/1
  # GET /related_refs/1.json
  def show
  end

  # GET /related_refs/new
  def new
    @related_ref = RelatedRef.new
  end

  # GET /related_refs/1/edit
  def edit
  end

  # POST /related_refs
  # POST /related_refs.json
  def create
    @related_ref = RelatedRef.new(related_ref_params)

    respond_to do |format|
      if @related_ref.save
        format.html {redirect_to @related_ref, notice: 'Related ref was successfully created.'}
        format.json {render :show, status: :created, location: @related_ref}
      else
        format.html {render :new}
        format.json {render json: @related_ref.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /related_refs/1
  # PATCH/PUT /related_refs/1.json
  def update
    respond_to do |format|
      if @related_ref.update(related_ref_params)
        format.html {redirect_to @related_ref, notice: 'Related ref was successfully updated.'}
        format.json {render :show, status: :ok, location: @related_ref}
      else
        format.html {render :edit}
        format.json {render json: @related_ref.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /related_refs/1
  # DELETE /related_refs/1.json
  def destroy
    @related_ref.destroy
    respond_to do |format|
      format.html {redirect_to related_refs_url, notice: 'Related ref was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_related_ref
      @related_ref = RelatedRef.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def related_ref_params
      params.require(:related_ref).permit(:owner_object_type, :owner_object_id, :title, :rel, :object_type, :object_id)
    end
end
