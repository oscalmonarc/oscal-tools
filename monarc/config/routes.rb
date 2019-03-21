Rails.application.routes.draw do
  
  default_url_options :host => "#{ENV['MONARC_URL'] || '127.0.0.1:3000' }"
  
  
  
    # Pages for adding Items
  get  'search_params', :to => 'application#search_params'
  get 'db_count', :to => 'application#db_count'
  get 'dump_all', :to => 'application#dump_all'
  get 'find',  :to => 'application#find'
  
  
  
  resources :active_storage
  resources :assessments do 
        get  'add_assessment_object', on: :member 
        get  'add_related_control', on: :member
        get 'dump_all', on: :collection 
    end
    
  resources :assessment_objects do 
    get 'dump_all', on: :collection
  end
  resources :component_domains
  
  resources :components do 
    get 'add_implementation',  to: 'control_implementations#new'
    get 'dump_all', on: :collection
    get 'add_child_component', on: :member
  end
  
  resources :control_implementations do 
    get 'dump_all', on: :collection
  end
  
  resources :control_overlays do 
    get 'dump_all', on: :collection
  end
  
  resources :data_classifications
  resources :domain_environments do 
    get 'add_subdomain' , on: :member
    get 'dump_all', on: :collection
  end
    
    
  resources :docs do
    get  'import/:import_action', on: :member,  to: 'docs#import'
    get  'upload_from_folder', on: :collection
    get  'convert_csv_1253' , on: :member
    get  'convert_oscal_xml', on: :member
    get  'convert_oscal_json', on: :member
    get  'convert_800_53_txt', on: :member
    get  'convert_800_53a', on: :member
    get  'convert_800_53_txt_rev5', on: :member
    get  'convert_accessibility_overlay', on: :member
    get  'convert_pii_overlay', on: :member
    get  'convert_intellegence_overlay', on: :member
    get  'impact_levels_nist', on: :member
    get  'import_provider_controls', on: :member
    get  'import_domains', on: :member
    get  'import_labels', on: :member
    get  'import_components', on: :member
    get  'dump_all', on: :collection
  end
   
  resources :guidances do 
      get  'add_related_control', on: :member 
  end
  
  resources :impact_levels do 
    get  'find_baseline/confidentiality/:confidentiality/integrity/:integrity/availability/:availability', on: :collection , to: 'impact_levels#find_baseline' 
    get  'find_baseline/:policy/:confidentiality/:integrity/:availability', on: :collection , to: 'impact_levels#find_baseline'
    get  'find_baseline', on: :collection
    get  'compare_levels', on: :collection
    get  'add_to_domain', on: :member, to: 'impact_levels#new'
    get  'show_controls', on: :member, to: 'impact_levels#show_controls'
    
      
  end
  resources :items do 
    get  'add_item', on: :member 
    get  'add_related_control', on: :member 
  end
  
  resources :labels do
    get 'add_child', on: :member
    get 'dump_all', on: :collection
  end
    
  resources :objectives do 
    get  'add_objective', on: :member 
    get  'add_related_control', on: :member 
      
  end
  resources :overlays do
    get  'find_baseline', on: :collection
    get 'dump_all', on: :collection
    get 'compare_overlays', on: :collection
  end
  
  resources :overlay_fields
  resources :overlay_field_options
  resources :params
  resources :param_values
  resources :related_refs
  resources :refs
  
  resources :providers do
    get  'name/:name', on: :collection, to: 'providers#show' 
    get 'add_component', on: :member,  to: 'components#new'
    get 'add_domain', on: :member,  to: 'domain_environments#new'  
    get 'dump_all', on: :collection
    get ':parent_id/add_sub_provider', on: :member, to: 'providers#show'
  end
  
  resources :related_labels do 
    get 'dump_all', on: :collection
    get 'add_to/:object_id/:object_type/', on: :collection, to: 'related_labels#add_to'
  end
  resources :requirements do 
    get 'dump_all', on: :collection
  end
  
  resources :security_controls do 
    get 'add_param',  on: :member
    get 'add_statement', on: :member
    get 'add_item', on: :member
    get 'add_assessment', on: :member
    get 'add_objective', on: :member
    get 'add_guidance', on: :member
    get 'dump_all', on: :collection
  end
    
  
  resources :security_control_families do
    get 'add_security_control', on: :member
    post 'add_security_control', on: :member
    
    get 'dump_all', on: :collection
  end
    
  
  get 'params/:param_id/add_value',  :to => 'param_values#new'
  get 'policy/:policy_name/version/:version/security_control/show_all', :to => 'security_controls#show_full_policy'
  post 'policy/:policy_name/version/:version/new_control_family/', :to => 'security_control_families#new'
  get 'policy/:policy_name/version/:version/security_control/:control_id',
            :to => 'security_controls#find_by_fields', :constraints => { :control_id => /[^\/]+/ }
  post 'policy/:policy_name/version/:version/security_control/:control_id',
       :to => 'security_controls#find_by_fields', :constraints => { :control_id => /[^\/]+/ }
    
  get 'policy/:policy_name/version/:version/security_control/:control_id/compare/:with_version',
      :to => 'security_controls#compare', :constraints => { :control_id => /[^\/]+/ }
  post 'policy/:policy_name/version/:version/security_control/:control_id/compare/:with_version',
       :to => 'security_controls#compare', :constraints => { :control_id => /[^\/]+/ }
  get 'policy/:policy_name/version/:version/dump_by_object', :to => 'security_policies#dump_by_object'
  get 'policy/:policy_name/version/:version/dump_by_object/:object_name', :to => 'security_policies#dump_by_object'
  post 'policy/:policy_name/version/:version/dump_by_object/:object_name', :to => 'security_policies#dump_by_object'
  get 'policy/:policy_name/version/:version/dump_me', :to => 'security_policies#dump_me'
  post 'policy/:policy_name/version/:version/dump_me', :to => 'security_policies#dump_me'
  
  get 'policy/:policy_name/version/:version/security_control_family/:family', :to => 'security_control_families#by_family'
  get 'policy/:policy_name/version/:version/security_control_family/:family/compare/:id', :to => 'security_control_families#compare'
  post 'policy/:policy_name/version/:version/security_control_family/:family/compare/:id', :to => 'security_control_families#compare'
  
  get 'policy/:policy_name/version/:version/compare/:with_version', :to => 'security_policies#compare'
  post 'policy/:policy_name/version/:version/compare/:with_version', :to => 'security_policies#compare'
  

  
  get 'policy/:policy_name/version/:version/', :to =>
  'security_policies#by_version', :constraints => { :control_id => /[^\/]+/ }
  post 'policy/:policy_name/version/:version/', :to =>
  'security_policies#by_version', :constraints => { :control_id => /[^\/]+/ }
    
  resources :security_policies do 
    get 'populate', on: :collection
    get 'dump_all', on: :collection
  end
    
  resources :statements do 
    get 'add_param', on: :member 
    get 'add_item', on: :member
    get 'add_related_control', on: :member 
  end
  
  
  
  
  
  
  #This stuff is for the API
    get 'api_examples', :to => 'application#api_examples'
    get 'api/v1/security_policies/', :to => 'security_policies#api_index'
    get 'api/v1/security_policies/api_commands', :to => 'security_policies#api_commands'
    get 'api/v1/security_policies/:id', :to => 'security_policies#api_show_object'
    get 'api/v1/security_policies/:id/detailed/', :to => 'security_policies#api_show_detailed'
    get 'api/v1/security_policies/:id/detailed/oscal', :to => 'security_policies#api_show_oscal'
    get 'api/v1/security_policies/:id/security_control_families', :to => 'security_policies#api_show_families'
    get 'api/v1/security_policies/:id/security_controls', :to => 'security_policies#api_show_controls'
    
    get 'api/v1/security_policy/:id', :to => 'security_policies#api_show_object'
    get 'api/v1/security_policy/:id/detailed/', :to => 'security_policies#api_show_detailed'
    get 'api/v1/security_policy/:id/detailed/oscal', :to => 'security_policies#api_show_oscal'  
    get 'api/v1/security_policy/:id/security_control_families', :to => 'security_policies#api_show_families'
    get 'api/v1/security_policy/:id/security_controls', :to => 'security_policies#api_show_controls'
    
    get 'api/v1/security_controls/', :to => 'security_controls#api_index'
    get 'api/v1/security_controls/api_commands', :to => 'security_controls#api_commands'
    get 'api/v1/security_controls/:id', :to => 'security_controls#api_show_object'
    get 'api/v1/security_controls/:id/detailed', :to => 'security_controls#api_show_detailed'
    get 'api/v1/security_controls/:id/detailed/oscal', :to => 'security_controls#api_show_oscal'
    
    
    get 'api/v1/impact_levels/', :to => 'impact_levels#api_index'
    get 'api/v1/impact_levels/api_commands', :to => 'impact_levels#api_commands'
    get 'api/v1/impact_levels/controls/policy/:policy/confidentiality/:confidentiality/integrity/:integrity/availability/:availability', 
        :to => 'impact_levels#api_grab_controls'
    get 'api/v1/impact_levels/controls/policy/:policy/conf/:confidentiality/integ/:integrity/avail/:availability', 
        :to => 'impact_levels#api_grab_controls'
    get 'api/v1/impact_levels/controls/policy/:policy/c/:confidentiality/i/:integrity/a/:availability', 
        :to => 'impact_levels#api_grab_controls'
    get 'api/v1/impact_levels/controls/p/:policy/c/:confidentiality/i/:integrity/a/:availability', 
        :to => 'impact_levels#api_grab_controls'
    get 'api/v1/impact_levels/controls/:policy/:confidentiality/:integrity/:availability', 
        :to => 'impact_levels#api_grab_controls'  
      
    post 'api/v1/impact_levels/controls', :to => 'impact_levels#api_grab_controls'
    get 'api/v1/impact_levels/:id', :to => 'impact_levels#api_show_object'
    get 'api/v1/impact_levels/:id/detailed', :to => 'impact_levels#api_show_detailed'
    get 'api/v1/impact_levels/:id/detailed/oscal', :to => 'impact_levels#api_show_oscal'
    
    
    get 'api/v1/security_control_families/', :to => 'security_control_families#api_index'
    get 'api/v1/security_control_families/api_commands', :to => 'security_control_families#api_commands'
    get 'api/v1/security_control_families/:id', :to => 'security_control_families#api_show_object'
    get 'api/v1/security_control_families/:id/detailed', :to => 'security_control_families#api_show_detailed'
    get 'api/v1/security_control_families/:id/detailed/oscal', :to => 'security_control_families#api_show_oscal'
    get 'api/v1/security_control_families/:id/security_controls', :to => 'security_control_families#api_show_controls'
    
    
    
    get 'api/v1/policy/:policy_name/version/:version/', :to => 'security_policies#api_show_object'
    get 'api/v1/policy/:policy_name/version/:version/all', :to => 'security_policies#api_show_detailed'
    get 'api/v1/policy/:policy_name/version/:version/all/oscal', :to => 'security_policies#api_show_oscal'
    get 'api/v1/policy/:policy_name/version/:version/security_control_families', :to => 'security_policies#api_show_families'
    
    get 'api/v1/policy/:policy_name/version/:version/security_control_families/abv/:abv', 
        :to => 'security_control_families#api_show_object'
    get 'api/v1/policy/:policy_name/version/:version/security_control_families/abv/:abv/detailed', 
        :to => 'security_control_families#api_show_detailed'
    get 'api/v1/policy/:policy_name/version/:version/security_control_families/abv/:abv/detailed/oscal', 
        :to => 'security_control_families#api_show_oscal'
    get 'api/v1/policy/:policy_name/version/:version/security_control_family/abv/:abv', 
        :to => 'security_control_families#api_show_object'
    get 'api/v1/policy/:policy_name/version/:version/security_control_family/abv/:abv/detailed', 
        :to => 'security_control_families#api_show_detailed'
    get 'api/v1/policy/:policy_name/version/:version/security_control_family/abv/:abv/detailed/oscal', 
        :to => 'security_control_families#api_show_oscal'
    
    get 'api/v1/policy/:policy_name/version/:version/security_control_families/title/:title', 
        :to => 'security_control_families#api_show_object'
    get 'api/v1/policy/:policy_name/version/:version/security_control_families/title/:title/detailed', 
        :to => 'security_control_families#api_show_detailed'
    get 'api/v1/policy/:policy_name/version/:version/security_control_families/title/:title/detailed/oscal', 
        :to => 'security_control_families#api_show_oscal'
    get 'api/v1/policy/:policy_name/version/:version/security_control_family/title/:title', 
        :to => 'security_control_families#api_show_object'
    get 'api/v1/policy/:policy_name/version/:version/security_control_family/title/:title/detailed', 
        :to => 'security_control_families#api_show_detailed'
    get 'api/v1/policy/:policy_name/version/:version/security_control_family/title/:title/detailed/oscal', 
        :to => 'security_control_families#api_show_oscal'
    
    get 'api/v1/policy/:policy_name/version/:version/security_controls', :to => 'security_policies#api_show_controls'
    get 'api/v1/policy/:policy_name/version/:version/security_control/:control_id/', :to => 'security_controls#api_show_object'
    get 'api/v1/policy/:policy_name/version/:version/security_control/:control_id/detailed', :to => 'security_controls#api_show_detailed'
    get 'api/v1/policy/:policy_name/version/:version/security_control/:control_id/detailed/oscal', :to => 'security_controls#api_show_oscal'
    
    
    get 'api/v1/assessments/', :to => 'assessments#api_index'
    get 'api/v1/assessments/api_commands', :to => 'assessments#api_commands'
    get 'api/v1/assessments/:id', :to => 'assessments#api_show_object'
    get 'api/v1/assessments/:id/detailed', :to => 'assessments#api_show_detailed'
    get 'api/v1/assessments/:id/detailed/oscal', :to => 'assessments#api_show_oscal'
    
    get 'api/v1/guidances/', :to => 'guidances#api_index'
    get 'api/v1/guidances/api_commands', :to => 'guidances#api_commands'
    get 'api/v1/guidances/:id', :to => 'guidances#api_show_object'
    get 'api/v1/guidances/:id/detailed', :to => 'guidances#api_show_detailed'
    get 'api/v1/guidances/:id/detailed/oscal', :to => 'guidances#api_show_oscal'
    
    
    get  'api/v1/items/show/oscal/:id', :to => 'items#api_oscal'
  
  
  
  
  root to: "security_policies#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #get '/rails/active_storage/blobs/:signed_id/:filename(.:format)' , :to => 'active_storage#show'
  #get '/rails/active_storage/blobs/:signed_id/*filename(.:format)' , :to => 'active_storage/blobs#show'
  
  #get '*path' => redirect('/')
  #post '*path' => redirect('/')
end
