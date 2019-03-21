module SharedFunctions
  include Rails.application.routes.url_helpers
   
   def default_url_options
     Rails.application.routes.default_url_options
   end
      
   def top_parents_only(objects)
    options = [] 
    objects.each do |object|
      options << top_parent(object)
    end  
     options = options.uniq
    return options
   end
  
   def labels
     object = self
     object_type = object.class.name.capitalize
     object_id = object.id
     references = []
     references = RelatedLabel.where(object_type: object_type, object_id: object_id)
     if references != nil
       references = references.uniq
       return references
     else
       return nil
     end
  end

    
  def destory_link(the_object)
    the_url = polymorphic_path(the_object) 
    the_link = "<a class='btn btn-sm' href='#{the_url}' data-method='delete'>             
      <i class='pg-trash'></i><span class='bold'>Delete</span>
    </a>"
    
    return the_link.html_safe
  end
  
   def grab_tree(object, output)
     if (object.parent != nil)
      output << object.parent
      if (object.parent.parent !=nil)
        output = grab_tree(object.parent, output)
      end 
      return output
    end
   end
  
   def is_enumerable?(object)
    object.is_a? Enumerable
  end
  
   def parent_link(object, output)
     
     if (object.parent != nil)
       output =  "#{object.parent.click_link} > " + output
       if (object.parent.parent != nil)
        output =  parent_link(object.parent, output)
       end
       return output.html_safe
     end
   end
   
   
   def top_parent(object)
    if (object.parent != nil)
      top_parent(object.parent)
    else
      return object
    end
   end
      
   def to_api_url(tmpurl)
     the_url = "<a href =#{tmpurl} target='_blank'>#{tmpurl}</a><br>"
     return the_url.html_safe
   end
   
   def base_az(num)
        # temp variable for converting base
      temp = num
      # the base 26 (az) number
      az = ''
    
      while temp > 0
    
        # get the remainder and convert to a letter
        num26 = temp % 26
        temp /= 26
    
        # offset for lack of "0"
        temp -= 1 if num26 == 0
    
        az = (num26).to_s(26).tr('0-9a-p', 'ZA-Y') + az
      end
    
        return az
      return az
    end 
  
    def roman(num)
      roman_num = {
            1000 => "M",  
             900 => "CM",  
             500 => "D",  
             400 => "CD",
             100 => "C",  
              90 => "XC",  
              50 => "L",  
              40 => "XL",  
              10 => "X",  
                9 => "IX",  
                5 => "V",  
                4 => "IV",  
                1 => "I",  
          }
      n = num
      roman = ""
      roman_num.each do |value, letter|
        roman << letter*(n / value)
        n = n % value
      end
      return roman
    end
    
    def check_attribute(the_attirbute)
      if ((the_attirbute.nil?) || (the_attirbute.size ==0) ) 
       return false
     else
       return true
     end
    end
  
  
   
  
     
   def convert_level(num, level)
      if (level == 1)
        return "#{num}. "
    elsif (level ==2)
      output = base_az(num).downcase
      return "#{output}. "
      else
        level = level - 2
        convert_level(num, level)
      end
   end
   
   def enumerable?(object)
    object.is_a? Enumerable
   end
   
  def grab_object(the_object_id, object_name)
      puts "object_name: #{object_name} - the_object_id#{the_object_id}"    
      the_object  = object_name.capitalize.constantize.find(the_object_id)
      return the_object
  end
    
    
   def grab_enhancements(security_control)
     the_urls = ""
   controls = security_control.children
   controls = controls.sort 
    
   if has_data?(controls)
     controls.each do |child|
       the_urls = the_urls+ "   |   #{child.the_url}"
     end
   end
   the_urls = the_urls+ "<br>"
     return the_urls.html_safe
   end
    
   def clean_url(the_url)
     the_url = the_url.gsub " ", "%20"
     return the_url
   end
   
    def check_missing_related_controls
      
      refs = RelatedRef.where(object_id: nil)
      if has_data?(refs)
        refs.each do |ref|
          if (ref.rel ==  "incorporated-into")
          ref = ref.set_missing_related_control
        end
      end
    end
  end
   
  
  
  def has_data?(object)
    if (object != nil )
      if (object.kind_of?(ActiveRecord::Associations::CollectionProxy)) || object.kind_of?(ActiveRecord::Relation) || (object.kind_of?(Array)) 
        if (object.count > 0)
         return true
        else 
          return false
        end
      elsif (object != "")
        return true
      else 
        return false
      end
    else
      return false
    end
  end
  
   
   def assessments_for_select
     return Assessment.all.map { |m| [m.name, m.id] }
   end 
   
   def guidances_for_select
     return Guidance.all.map { |m| [m.name, m.id] }
   end
   
   def items_for_select
     return  Item.all.map { |m| [m.name, m.id] }
   end
   
   def objectives_for_select
     return Objective.all.map { |m| [m.name, m.id] }
   end
   
   def params_for_select
     return Param.all.map { |m| [m.name, m.id] }
   end
   
   def requirements_for_select
     return  Requirement.all.map { |m| [m.name, m.id] }
   end
   
   
   def security_control_families_for_select
     return  SecurityControlFamily.all.map { |m| [m.abv, m.id] }
   end
   
   def security_controls_for_select
     return SecurityControl.includes( :objectives, :statements, {statements: :items}).all.map { |m| [m.name, m.id] }
   end
   
   
   
   def security_policies_for_select
    return SecurityPolicy.all.map { |m| [m.policy_version, m.id] }
   end
   
   def statements_for_select
    return Statement.all.map { |m| [m.name, m] }
   end
   
   def providers_for_select
    return Provider.all.map { |provider| [provider.name , provider.id] }
   end 
   
   def inheritance_type_options 
     return [["Common", "Common"], ["Hybrid", "Hybrid"], ["System - Specific", "System - Specific"]]
   end   
   
   def components_for_select
      return Component.all.map { |component| [component.name , component.id] }
   end
    
   def get_controls_with_children(the_object)
     if (the_object != nil) && (the_object.security_control != nil)
      return the_object.security_control.includes( :objectives, :statements, {statements: :items}).all
    else
     return nil
    end
   end
   
    
  def get_component(the_object)
    component_id = nil
    the_component = nil
      if (the_object != nil) &&(the_object.component_id != nil)
        component_id = the_object.component_id
      elsif ( params[:component_id] != nil)
        component_id = params[:component_id]
      end
      if (component_id != nil)
        the_component = Component.find(component_id)
      end
      return the_component 
  end 
 
   def get_provider(the_object)
     provider_id = nil
     provider  = nil
     if (the_object.provider_id != nil)
        provider_id = the_object.provider_id
        puts "the_object.provider_id "
        
     elsif (params[:provider_id] != nil)
       puts "params[:provider_id] = #{params[:provider_id]}"
       
       provider_id = params[:provider_id]
     end
     if (provider_id != nil)
       provider = Provider.find(provider_id)       
     end
     return provider 
   end
   
     
end  
