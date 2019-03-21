class ControlImplementation < ApplicationRecord
  acts_as_tree order: "id"

  belongs_to :component, optional: true
  belongs_to :domain_environment, optional: true
  belongs_to :provider, optional: true
  belongs_to :security_control
  belongs_to :security_policy
  belongs_to :objective, optional: true
  belongs_to :statement, optional: true
  belongs_to :item, optional: true
  
  
  belongs_to :parent, class_name: "ControlImplementation", optional: true
  
  before_create :set_security_control_and_policy
  before_validation :set_security_control_and_policy
  
  validates_presence_of :security_policy_id, :security_control_id, :implementation_method 
  
  def set_security_control_and_policy
    if (self.security_control.id != nil)
        self.security_policy = self.security_control.security_policy  
    end
  end
  
  def click_link
        link = "<a href='/control_implementation/#{self.id}'>#{self.security_control.control_id}</a>"
        return  link.html_safe
  end
  
  def domain_environment_click_link
    link = ""
    if (self.domain_environment != nil)
      link = self.domain_environment.click_link
    end
    return link
  end
  
  def compare_except_domain_to(object2)
    object1= self
    
    if ((object1.provider.click_link == object2.provider.click_link) && 
        (object1.security_control.click_link == object2.security_control.click_link) &&   
        (object1.security_policy.click_link == object2.security_policy.click_link) &&
        (object1.inheritance_type == object2.inheritance_type) &&
        (object1.implementation_method == object2.implementation_method) &&    
        (object1.required == object2.required))
        return true
    else
      return false
    end
  end
  
  def sanitzied_implementation_method
    implementation_method = self.implementation_method.gsub " Notes:", "<br><br>Notes:"
    implementation_method = implementation_method.gsub "?s", "'s"
    implementation_method = implementation_method.gsub " http:", "<br><br>http:"
    implementation_method = implementation_method.gsub " https:", "<br><br>https:"
    implementation_method = implementation_method.force_encoding("UTF-8")
    return implementation_method 
  end
  
  def objective_link
    if has_data?(self.objective)
      return self.objective.click_link
    else
      return nil
    end 
  end
  
  def statement_link
    if (self.statement != nil)
      return self.statement.click_link
    else
      return nil
    end
  end
  
  def domain_environment_link
    if (self.domain_environment != nil)
      return self.domain_environment.click_link
    else
      return nil
    end
  end
  
  
  # methods-- The control Implementations, group_by - The object you are grouping unique records for 
  def self.unique_control_implementations(the_object)
    if (the_object != nil) 
      if (the_object.is_a? Enumerable)
        methods = the_object
        group_by = the_object.first.class.name.downcase
      else
        methods = the_object.control_implementations
        group_by = the_object.class.name.downcase
      end
    end
      
      tmp_methods = []
      if (methods != nil) && (methods.count > 0)
        
        methods.each do |tmp_method|
          implementation_method  =""
          the_method = tmp_methods.select { |check_method| 
            
            check_method[:component].to_s == tmp_method.component.click_link &&
            check_method[:security_control].to_s == tmp_method.security_control.click_link &&   
            check_method[:provider] == tmp_method.provider.click_link &&
            check_method[:statement] == tmp_method.statement_link &&
            check_method[:objective] == tmp_method.objective_link &&
            check_method[:implementation_method] == tmp_method.sanitzied_implementation_method}.first
          if (the_method != nil)
            if !((the_method[:domain_environment] != nil) && (the_method[:domain_environment].include? "#{tmp_method.domain_environment_link}"))
              the_method[:domain_environment] =  "#{the_method[:domain_environment]}" + " - #{tmp_method.domain_environment_link}"
            end
            if (tmp_method.statement != nil)
              if !((the_method[:statement] != nil) && (the_method[:statement].include? "#{tmp_method.statement_link}"))
                the_method[:statement] =  "#{the_method[:statement]}" + "  - #{tmp_method.statement_link}"
              end
            end
            if (tmp_method.objective != nil)
              if !((the_method[:objective] != nil) && (the_method[:objective].include? "#{tmp_method.objective_link}"))
                the_method[:objective] =  "#{the_method[:objective]}" + "  - #{tmp_method.objective_link}"
              end
            end
                      
          else
            
            statement = nil
            domain_environment = nil
            implementation_method = nil
            
            
            
            if (tmp_method.domain_environment != nil)
              domain_environment = tmp_method.domain_environment.click_link
            end
            if (tmp_method.implementation_method != nil)
              implementation_method = tmp_method.implementation_method
              implementation_method = implementation_method .gsub " Notes:", "<br><br>Notes:"
              implementation_method = implementation_method .gsub "?s", "'s"
              implementation_method = implementation_method .gsub " http:", "<br><br>http:"
              implementation_method = implementation_method .gsub " https:", "<br><br>https:"
           
            end
            check_method = {component: tmp_method.component.click_link,
            security_control: tmp_method.security_control.click_link,     
            security_policy: tmp_method.security_policy.click_link,
            provider: tmp_method.provider.click_link,
            objective: tmp_method.objective_link,
            statement: tmp_method.statement_link,
            domain_environment: tmp_method.domain_environment_link,
            inheritance_type: tmp_method.inheritance_type,  
            implementation_method: implementation_method,      
            required: tmp_method.required}
            tmp_methods << check_method
          end   
        end 
        
      end
      
      return tmp_methods
    end
    
    
end
