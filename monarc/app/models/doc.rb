class Doc < ApplicationRecord
  include Rails.application.routes.url_helpers
  
  belongs_to :security_policy, optional: true
  belongs_to :provider, optional: true
  has_one_attached :the_doc
  
  #belongs_to :declarations, class_name: "Doc", optional: true 
  
  #Grabs the file url for downloading
  def grab_file_link
    url = ""
    if (self.the_doc.attached?)
      link = rails_blob_path(self.the_doc, disposition: 'attachment')
      url = "<a href='#{link}'> #{self.the_doc.filename}</a>"
    end
    
    return url.html_safe  
  end
  
  #Grabs the path to the file to parse it.
  def grab_file_path 
    file_key = self.the_doc.key 
    dir1 = file_key[0,2]
    dir2 = file_key[2,2]
    path = "storage/#{dir1}/#{dir2}/#{file_key}"
    return path 
  end
  
  def self.erase_clean_storage(confirm)
    if (confirm)
      dir1 = "storage/"
      FileUtils.rm_rf(dir1)
    end
  end
    
  
  #Should delete the folder once the file is deleted, and no other files are in the folder.
  def clean_up(the_folder)
    if (the_folder != nil)
      dir1 = "storage/#{the_folder[0,2]}"
      dir2 = "#{dir1}/#{the_folder[2,2]}"
      check_for_files(dir2)
      check_for_files(dir1)
    end
  end
  
  #checks to see if the folder is empty.
  def check_for_files(directory)
    files = Dir["#{directory}/*"]
    if (files.size == 0) 
      FileUtils.rm_rf(directory)
    end
  end
  
  #creates a url based on action for import
  def grab_action_url
    url = "/docs/#{self.id}/import/"
    if (self.doc_type == "oscal")
      url = url + "convert_from_oscal"
    elsif  (self.doc_type == "800-53.text")
      url = url + "convert_800_53_txt"
    elsif (self.doc_type == "800-53a.text")
      url = url + "convert_800_53a"
    elsif (self.doc_type == "800-53_rev_5_text")
      url = url + "convert_800_53_rev_5_text"
    elsif (self.doc_type == "impact_levels_nist.json")
      url = url + "impact_levels_nist"
    elsif (self.doc_type == "oscal.json")
      url = url + "convert_from_oscal_json"
    elsif (self.doc_type == "1253.csv")
      url = url + "convert_csv_1253"
    elsif (self.doc_type == "provider_controls")
      url = url + "import_provider_controls"
    elsif (self.doc_type == "domain_objects")
      url = url + "import_domains"
    elsif (self.doc_type == "label_objects")
      url = url + "import_labels"
    elsif (self.doc_type == "component_objects")
      url = url + "import_components"
    elsif (self.doc_type == "accessibility_overlay_csv")
      url = url + "convert_accessibility_overlay"
    elsif (self.doc_type == "intellegence_overlay_csv")
      url = url + "convert_intellegence_overlay" 
    elsif (self.doc_type == "pii_overlay_csv")
      url = url + "convert_pii_overlay" 
    end 
    
    
    if (url != "/docs/#{self.id}/import/")
      return url
    else 
      return nil 
    end
  end
  
  #finds the declaration object, not sure why this is here. 
  def declaration
    return Doc.find(self.declarations_id)
  end
  
  #returns the contents of the declaration file 
  def grab_declaration
    require 'open-uri'
    the_file = nil
    if (self.declaration != nil)
      declaration = self.declaration
      path = declaration.grab_file_path
      if (declaration.doc_type == "json_declaration")
        require 'json'
        the_file =JSON.parse(File.read(path))
      end
    end
    return the_file    
  end
end
