require './lib/espresso/shared_functions'

class ApplicationController < ActionController::Base
  include Response
  include ExceptionHandler
  include SharedFunctions
  
  before_action :set_search_status, :set_last_page
  
  def set_last_page
    session[:return_to] = request.referer
  end
  
  def search_params
    render "layouts/page/search_params"
  end
  
  def api_examples
    render "layouts/page/api_examples"
  end
  
  def db_count
      render "layouts/page/db_count"
  end
  
  # post dump_all
  def dump_all
    render "layouts/page/dump_all"
  end
  def dump_by_object
    render "layouts/page/dump_by_object"
  end
  
  def dump_components
      render "layouts/page/dump_components"
  end
  
  def dump_implementations
    render "layouts/page/dump_implementations"
  end
  
  def dump_domains
    render "layouts/page/dump_domains"
  end
  
  
  def find
      if (params[:security_control] != nil)
        search_param = params[:security_control][:name]
        #Check if search is a param
        if search_param.include?("_prm_")
          @param = Param.where(params_id: search_param).first
          redirect_to @param
        elsif search_param.include?("_obj_")
          @objective = Objective.where(objective_id: search_param).first
          redirect_to @objective
        elsif search_param.include?("_smt_")
          @item = Item.where(item_id: search_param).first
          redirect_to @item
        else
          #Check if its an objective...
          objective_pattern = /([A-Z]{1,2}-[0-9]\([a-z]\)\([0-9]\))/
          item_pattern = /([A-Z]{1,2}-[0-9][a-z]\.(?:[0-9]\.)?)/
          if objective_pattern.match?(search_param)
            @objective = Objective.where(name: search_param).first
            redirect_to @objective
          elsif item_pattern.match?(search_param)
            @item = Item.where(name: search_param).first
            redirect_to @item
          else
            search_param = search_param.upcase
            bad_control = /([a-zA-Z][a-zA-Z])(\d+)/
            bad_control2 = /([a-zA-Z][a-zA-Z]) (\d+)/
            if (search_param.match?(bad_control))
              search_param = search_param.gsub(bad_control) {$1 + "-" + $2}
            elsif (search_param.match?(bad_control2))
              search_param = search_param.gsub(bad_control2) {$1 + "-" + $2}
            end
            @security_controls = SecurityControl.where('control_id LIKE :search OR name LIKE :search',
                                                       search: "%#{search_param}%").all.paginate(:page => params[:page]).order('control_id ASC')
            redirect_to security_controls_url(@security_controls)  
          end
        end
      else
        @security_controls = SecurityControl.includes(:security_policy,
                                                      :security_control_family).all.all.paginate(:page => params[:page]).order('control_id ASC')
        redirect_to security_controls_url(@security_controls)
      end
    end
  
  def set_search_status
    @search_status = false 
    if (params[:q] != nil)
      @search_status = true
    end  
  end
end

