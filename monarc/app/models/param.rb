class Param < ApplicationRecord
  acts_as_tree order: "id"
    
  belongs_to :parent, class_name: "Param", optional: true
  belongs_to :depends_on, class_name: "Param", optional: true
  belongs_to :security_control, optional: true
  belongs_to :requirement, optional: true
  belongs_to :statement, optional: true
  belongs_to :item, optional: true
  
  has_many :param_values, dependent: :destroy  
  
  
  #belongs_to :depends_on, class_name: "Param", optional: true
  
  #returns the url of this object
  def the_url
    return Rails.application.routes.url_helpers.param.url(self, only_path: true)
  end
  
  #gets the children as objects and stores as urls? Not sure what this was for. 
  def get_options
    the_children = self.grab_children
    the_urls = "No Options"
    if (the_children.size > 0)
      the_urls = ""
      the_children.each do |the_child|
        the_urls = the_urls + " " +  the_child.the_url + " <br>" 
      end
    end
    return the_urls
  end
  
  #Gets the children objects
  def grab_children
    the_children = Param.where(parent: self)
    return the_children
  end
  
  #Returns the url for this object
  def the_url
      url =  "<a href='/params/#{self.id}'>#{self.description}</a>"
      return url.html_safe  
  end
  
  #Returns the url for this object
  def the_url_full
    url =  "<a href='/params/#{self.id}'>#{self.params_id} </a>- #{self.description}"
    return url.html_safe  
  end
    
  #Grabs any param values set for this param.
  def grab_values
    the_urls = "Not Set"
    paramvalues = ParamValue.where(param: self)
    
    if (paramvalues.size > 0)
      the_urls = ""
      paramvalues.each do |param_value|
        the_urls = the_urls + " " +  param_value.the_url + " <br>"
      end
    end
    return the_urls.html_safe
  end
  
  #Link to add a new param 
  def value_url
  the_url = ""
    if (self.security_control != nil)
      the_parent = self.security_control
      the_url = "<a href='/params/#{self.id}/add_value'> Add Value </a>"
    end
    return the_url.html_safe
  end
end
