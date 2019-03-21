class DocsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_doc, only: [:show, :edit, :update, :destroy, :import]
  before_action :get_doc_url, only: [:convert_oscal_xml, :convert_oscal_json, :import_provider_controls,
    :import_domains, :import_labels, :import_components, :convert_accessibility_overlay, :convert_intellegence_overlay, 
    :convert_pii_overlay,  :convert_800_53_txt, :convert_800_53a, :impact_levels_nist, :convert_csv_1253, :convert_800_53_txt_rev5] 
  
  # GET /docs 
  # GET /docs.json
  def index
    @q = Doc.ransack(params[:q])
    @docs = @q.result.includes(:security_policy).page(params[:page]).order('id ASC')
  end

  # GET /docs/dump_all
  def dump_all
    Doc.all.destroy_all 
    flash[:success] = "All Docs have been erased."
    redirect_to session[:return_to]
  end
    
  # GET /docs/1
  # GET /docs/1.json
  def show
  end

  # GET /docs/new
  def new
    @doc = Doc.new
  end
  # GET /docs/upload_from_folder
  # POST /docs/upload_from_folder
  def upload_from_folder
  
  end
  
  # GET /docs/1/edit
  def edit
  end
  def import 
    @action_type = params[:import_action]
  end
  
  def convert_oscal_xml
    render :partial => "convert_oscal_xml" 
  end
  
  def convert_accessibility_overlay
    render :partial => "convert_accessibility_overlay"
  end
  
  def convert_intellegence_overlay
      render :partial => "convert_intellegence_overlay"
  end
  def convert_pii_overlay
      render :partial => "convert_pii_overlay"
  end
    
  def import_provider_controls
    render :partial => "import_provider_controls"
  end

  def import_domains
    render :partial => "import_domains"
  end
  
  def import_labels
     render :partial => "import_labels"
  end
  
  def import_components
    render :partial => "import_components"
  end
  
  def convert_oscal_json
    render :partial => "convert_oscal_json" 
  end
  
  def convert_800_53_txt
    render :partial => "convert_800_53_txt" 
  end
  
  def convert_800_53_txt_rev5
   render :partial => "convert_800_53_txt_rev5" 
  end
  
  def convert_800_53a
    render :partial => "convert_800_53a" 
  end
  
  def convert_csv_1253
    render :partial => "convert_csv_1253"
  end
  
  def impact_levels_nist
    render :partial => "impact_levels_nist" 
  end
  # POST /docs
  # POST /docs.json
  def create 
    @doc = Doc.new(doc_params)
    respond_to do |format|
      if @doc.save
        format.html {redirect_to @doc, notice: 'Doc was successfully created.'}
        format.json {render :show, status: :created, location: @doc}
      else
        format.html {render :new}
        format.json {render json: @doc.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /docs/1
  # PATCH/PUT /docs/1.json
  def update
    if (params[:doc][:declarations_id] != nil) && (params[:doc][:declarations_id] != '')
      tmp_doc_id = params[:doc][:declarations_id]
      tmp_doc = Doc.find(tmp_doc_id)
      @doc.declarations_id = tmp_doc.id
      #params[:doc][:declarations_id] = tmp_doc.id    
    end
    respond_to do |format|
      if @doc.update(doc_params)
        format.html {redirect_to @doc, notice: 'Doc was successfully updated.'}
        format.json {render :show, status: :ok, location: @doc}
      else
        format.html {render :edit}
        format.json {render json: @doc.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /docs/1
  # DELETE /docs/1.json
  def destroy
    the_folder = nil
    if (@doc.the_doc.attachment != nil)
      the_folder = @doc.the_doc.key
    end
    @doc.the_doc.purge
    @doc.clean_up(the_folder)
    @doc.destroy
    respond_to do |format|
      format.html {redirect_to docs_url, notice: 'Doc was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doc
      @doc = Doc.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def doc_params
      params.require(:doc).permit(:name, :description, :file_type, :url, :security_policy_id, 
                                  :the_doc, :doc_type, :declarations_id, :declarations, :action, :source_date, :imported, :provider_id)
    end
    def get_doc_url
      url = request.original_fullpath
      url_parsed = url.split "/"
      doc_id = url_parsed[2].to_i
      @doc = Doc.find(doc_id)
      
    end
end
