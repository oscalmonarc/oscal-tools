class ControlOverlay < ApplicationRecord
  belongs_to :security_policy
  belongs_to :domain_environment, optional: true
  belongs_to :overlay_field
  belongs_to :overlay_field_option, optional: true
  belongs_to :security_control, optional: true
  
  validates_presence_of :overlay_value
  
  
  def self.set_control_overlay(security_control, security_policy, overlay_field,  overlay_value, overlay_field_option)
    control_overlay = nil
    if (overlay_value != nil)
      overlay_value = overlay_value.gsub " ", ""
      control_overlay = ControlOverlay.find_or_create_by(security_control: security_control, overlay_field: overlay_field, security_policy: security_policy, overlay_value: overlay_value, overlay_field_option: overlay_field_option)
    end
    return control_overlay
  end
  
  def self.sort_by_control_id(controls)
    controls = controls.sort_by{|control_overlay| control_overlay[:security_control_id]}
     return controls
  end
  
  def self.find_control_options(selected_options, policy)
    if (selected_options != nil)
      controls = []
        options = "" 
        option_count = selected_options.count
        current_count = 1
        selected_options.each do |tmp_option|
          tmp_controls = ControlOverlay.includes(security_control: :security_control_family).where(overlay_field_option_id:  tmp_option[:overlay_field_option], security_policy_id: policy)
          controls = controls  + tmp_controls
            
        end
      
      controls = self.sort_by_control_id(controls)
      return controls
    else
      return nil
    end
  end
  
  def self.check_included_list(the_list, the_object, the_reason)
    new_reason = "#{the_object.overlay_field.overlay.name}"
    first_reason = "#{the_reason}#{new_reason}"
    control_found = false
    if (the_list != nil) && (the_list.count > 0)
      control_check = the_list.select {|full_control| full_control[:control] == the_object.security_control }.first
      if ((control_check != nil) && (control_check.count > 0)) 
        if !(control_check[:reason].include?(new_reason))
          control_check[:reason] = "#{control_check[:reason]}, #{new_reason}"
        end
        control_found = true
      end
    end
    if !(control_found)
      the_list << {control: the_object.security_control, reason: "#{first_reason}"}
    end
    return the_list
  end
  
  def self.aggrigate_controls(controls, nss)
    full_list =[]
    add_controls = []
    nss_controls = []
    remove_controls = []
      if (controls != nil) && (controls.count > 0)
        controls.each do |tmp_control_overlay|
          tmp_value = tmp_control_overlay.overlay_value.to_s
          if (tmp_value == "x") || (tmp_value == "X") || (tmp_value == "1")
            add_controls = ControlOverlay.check_included_list(add_controls, tmp_control_overlay, " added by: ")
          elsif (tmp_value == "+")
              nss_controls = ControlOverlay.check_included_list(nss_controls , tmp_control_overlay, " added by: ")
          elsif (tmp_value == "-") || (tmp_value == "-1") 
            remove_controls = ControlOverlay.check_included_list(remove_controls , tmp_control_overlay, " removed by: " )  
          else
            puts "error with control - #{tmp_control_overlay.inspect}: #{tmp_value}"
          end
        end
      end
      
      full_list = add_controls
      if (nss) && (nss_controls != nil) && (nss_controls.count > 0)
          nss_controls.each do |nss_control|
           # puts "nss_control - {nss_control}"
            if (full_list.select {|full_control| full_control[:control] == nss_control[:control] }.count == 0 )
              full_list << nss_control
            end
          end
      end
      add_controls = full_list
      
      if (remove_controls != nil)
        remove_controls.each do |control| 
          if !(full_list.include?(control))
            full_list << control
          end
        end
      end
    
      return {full_list: full_list, add_controls: add_controls, remove_controls: remove_controls}
      
  end
end
