class ParamValue < ApplicationRecord
  belongs_to :param
  belongs_to :param_value, optional: true
  
  
  #returns the url of this object 
  def the_url
        url =  "<a href='/param_values/#{self.id}'>#{self.the_value}</a>"
        return url.html_safe  
    end
    
end
