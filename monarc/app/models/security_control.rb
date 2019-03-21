class SecurityControl < ApplicationRecord
  acts_as_tree order: "control_id"
  
  has_many :params, dependent: :destroy
  has_many :statements, dependent: :destroy
  has_many :assessments, dependent: :destroy
  has_many :assessment_objects, through: :assessments, dependent: :destroy
  has_many :objectives, dependent: :destroy
  has_many :guidances, dependent: :destroy
  has_many :control_overlays, dependent: :destroy
  has_many :control_implementations, dependent: :destroy
  
  belongs_to :parent, class_name: "SecurityControl", optional: true
  belongs_to  :security_control_family
  belongs_to  :security_policy
  
  validates_presence_of :name, :control_id, :security_policy, :security_control_family, :status, :title
  
  
  before_destroy :clean_up
  
  def clean_up
    RelatedRef.clean_references_before_destory(self)
  end  
  def show_compare
     historic_controls = self.other_versions
     temp_output = ""
     if ((historic_controls != nil) && (historic_controls.size > 0)) 
       temp_output  = "  
       <strong>Other versions of this control:</strong>"
        historic_controls.each do |security_control|
          the_url = "#{self.just_url}/compare/#{security_control.security_policy.version}"
          temp_output  = temp_output  + "
            <input class='small_button' type='button' onclick=\"location.href='#{the_url}';\" value='Compare rev #{security_control.security_policy.version}' />       
            <input class='small_button' type='button' onclick=\"location.href='#{security_control.just_url}';\" value=\"View rev #{security_control.security_policy.version}\" />"
        end 
       temp_output  = temp_output  + ' </tr>
          </table>'
      end
  return temp_output.html_safe
  end
  #Returns the control_id as name cleaned.
  def grab_name
    name = self.control_id
    if name.include?(".")
      name = name.gsub ".", "("
      name = name + ")"
    end
    return name
  end
  
  
  def click_link
    link = "<a href='#{self.just_url}'>#{self.name}</a>"
    return  link.html_safe
  end
  
  #Returns other versions of this control from newer or older security policies
  def other_versions
    historic_controls = SecurityControl.where(control_id: self.control_id).where.not(security_policy_id: self.security_policy.id)
    return historic_controls 
  end
  
    
     
  #returns the url only 
  def just_url
    policy_name = self.security_policy.name
    version = self.security_policy.version
    url =  "/policy/#{policy_name}/version/#{version}/security_control/#{self.control_id}"
    return url 
  end
  
  #creates a clickable link of the object
  def the_url
    theurl = self.just_url()
    url =  "<a href='#{theurl}'>#{self.grab_name}</a>"
    return url.html_safe  
  end
  
  
 #Checks if the status is active.
 def check_active
  if (self.status == "Active")
    return true
  else 
    return false
  end
 end
 
  def get_withdrawn_reason
   reason = ""
    if !(check_active)
      reason = "["
      related = RelatedRef.where(rel: "incorporated-into", owner_object_type: "SecurityControl", owner_object_id: self.id)
      if (related != nil) && (related.count >0) 
        related.each do |ref|
          reason = reason +  "incorporated into: " + ref.grab_related_object_url 
        end
       end
      reason = reason + "]"
    end
   return reason.html_safe 
  end
  #Calls the convert_to_oscal_json method, saying children is false, and monarc ID is true.
  def show_oscal_with_eid
    return convert_to_oscal_json(false, true)
  end
   
   #Calls the convert_to_oscal_json method, saying children is true, and monarc ID is true.
   def show_oscal_detailed_with_eid
     return convert_to_oscal_json(true, true)
   end
  
   #Calls the convert_to_oscal_json method, saying children is true, and monarc ID is false.
   def show_oscal_detailed
     return convert_to_oscal_json(true, false)
   end
   
  #Grabs the Children statements objects in json
  def grab_json_statements(children, show_monarc_id)
    Jbuilder.new do |_json|
      statement_array = []
      self.statements.each do |statement|
         statement_array << statement.convert_to_oscal_json(children, show_monarc_id).attributes!    
      end
      return statement_array
    end
  end
  
  #Grabs the Children guidances objects in json
  def grab_json_guidances(children, show_monarc_id)
    Jbuilder.new do |_json|
      guidance_array = []
      if (self.guidances != nil) && (self.guidances.count > 0)
        self.guidances.each do |guidance|
          guidance_array << guidance.convert_to_oscal_json(children, show_monarc_id).attributes!    
        end
      end
     return guidance_array
    end
  end 
  
  #Grabs the Children objectives  objects in json
  def grab_json_objectives(children, show_monarc_id)
    Jbuilder.new do |_json|
      objective_array = []
      objectives = self.objectives.where(parent_id: nil)
      objectives.each do |objective|
        objective_array << objective.convert_to_oscal_json(children, show_monarc_id).attributes!
      end
      return objective_array
    end
  end

  #Grabs the Children assessments objects in json
  def grab_json_assessments(children, show_monarc_id)
      Jbuilder.new do |_json|
        assessment_array = [] 
        self.assessments.each do |assessment|
          assessment_array << assessment.convert_to_oscal_json(children, show_monarc_id).attributes!
        end
        return assessment_array
      end
 end
#Will return,an JSON object. 
#If Children is set to true, it will also include the children objects.
#If show_monarc_id is true, it will add an monarc_id to the output, which is not standard in OSCAL.  def convert_to_oscal_json(children, show_monarc_id)
def convert_to_oscal_json(children, show_monarc_id)  
  Jbuilder.new do |json|
     json.id self.control_id.downcase
     if (show_monarc_id)
      json.monarc_id self.id
     end
     json.class self.control_class
     json.title self.title

     if (children)  
       #Set Params
       if (self.params.count > 0 )
         json.params(self.params) do |param|
           #Rev 3 does not have param IDs
           if (param.params_id != nil)
             json.id param.params_id
           else
             json.id "PLEASESETME"
           end
           json.label param.description
         end
       end
       json.props do
         json.class "name"
         
         json.value self.name
       end
       json.parts do
         #Set Statements
         json.array! self.grab_json_statements(children, show_monarc_id)
         
         #Set Guidance
         json.array! self.grab_json_guidances(children, show_monarc_id)
         
         #Set Objectives
         json.array! self.grab_json_objectives(children, show_monarc_id)
         
         #Set Assessments
         json.array! grab_json_assessments(children, show_monarc_id)
         
       end     
     end
    #Set_References
    #ref_array = []
    #security_control.related_refs.each do |related_ref|
    #  ref_array << related_ref.show_oscal_detailed.attributes!
    #end  
    #json.references ref_array
     
  end

 end

 #checks the status of 2 control groups
 def analyze_control_groups(controls)
   if (controls != nil )
     full_list = []
     new_controls = []
     removed_controls = []
     remain_controls = []
     controls.each do |control|
       #check new controls
       if (control[:policy1] == nil)
         new_controls << control
         full_list << {control_id: control[:control_id], url: control[:url2],  status: "New", title: control[:title], control: control[:control2]} 
       elsif (control[:policy2] == nil)
         removed_controls << control
         full_list << {control_id: control[:control_id], url: control[:url1],  status: "Removed", title: control[:title], control: control[:control1]}
       elsif (control[:policy2] != nil) && (control[:policy1] != nil)
         remain_controls << control
         full_list << {control_id: control[:control_id], url: control[:url2], status: "Remain", title: control[:title], control: control[:control2]}
       end 
     end
     full_list = full_list.sort_by { |control| control[:control_id].to_s.split(/(\d+)/).map { |e| [e.to_i, e] } }
     results = {full_list: full_list, new_controls: new_controls.count, removed_controls: removed_controls.count, remain_controls: remain_controls.count}
     return results 
   end
 end
 
 #Combines 2 control groups and creates 1 array element per security control to remove duplication
 def combine_groups(security_controls, security_controls2, policy1_id, policy2_id)
     complete_list = []
     if (security_controls != nil)
       security_controls.each do |control|
         tmp_control = {control_id: control.control_id, title: control.title, policy1: control.security_policy_id, control1: control, 
           url1: control.the_url, status1: control.status, policy2: nil, status2: nil, url2: nil}
         complete_list << tmp_control  
       end
     end
     
     if (security_controls2 != nil)
       security_controls2.each do |control|
         stored_control = complete_list.select { |tmp_stored_control| tmp_stored_control[:control_id] == control.control_id}.first
         if (stored_control != nil) && (stored_control.count > 0) 
           stored_control[:policy2] = control.security_policy_id
           stored_control[:url2] = control.the_url
           stored_control[:status2] = control.status
           stored_control[:control2] = control
         else
            tmp_control = {control_id: control.control_id, title: control.title,  policy1: nil, url1: nil, status1: nil, 
             policy2: control.security_policy_id, status2: control.status, url2: control.the_url, control2: control}
             complete_list << tmp_control
         end   
       end
     end
     return complete_list
 end
  
end
