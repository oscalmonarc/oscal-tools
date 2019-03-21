require './lib/monarc/shared_functions'
module ApplicationHelper
  include SharedFunctions
  #Used to show links to children items
    def children_click_link(object)
         child_links = ""
       children = object.children
       if has_data?(children)
         children.each do |child|
           child_links = child_links + child.click_link + " | " 
           end
         end
         return child_links.html_safe
     end
     
    def show_tree(object)
       output = "#{object.click_link}" 
       
       if (object.parent != nil)
         puts "object.parent - #{object.parent}"
         output = parent_link(object, output)
       elsif (object.parent_id != nil )
         puts "object.parent_id - #{object.parent_id}"
       end
	   return output.html_safe
    end
     
     def encode_utf8(the_text)
       #Ignore the eclipse error, this works just fine.
       the_text = the_text.encode(Encoding.find('UTF-8'), {invalid: :replace, undef: :replace, replace: ''})
       return the_text 
     end
     
     def show_more(display_text, object_id)
       output = "<div> " 
       display_text = encode_utf8(display_text).html_safe
       if display_text.length > 250
         display = truncate(display_text, length: 250)
         output = output + " #{display_text}"
         output = output + " <a class='read-more-#{object_id}' href=''>...Read more</a>"
         output = output + " <script> 
           $('.read-more-#{object_id}').on('click', function(e) {
             e.preventDefault()
             $(this).parent().html('#{escape_javascript display_text}')
           })
         </script>"
       else 
         output = ""#{display_text}"
       end
       output = output + "</div> " 
       return output.html_safe 
     end
  def labels_show_tree(object)
       tree = ""
       labels = object.labels
       if has_data?(labels)
         labels.each do |label|
           tree = tree + show_tree(object) + "<br>" 
         end
       end
       return tree.html_safe
    end
      
    def convert_impact_level(level_type, impact_level)
         #low  red color = #F2DBDB
         #Mod white color =#FFFFFF
         #High blue color =#C6D9F1
         
         style =""
         fieldname=""
         if (level_type == 'conf')
           style = " style='background-color: #F2DBDB;' "
           fieldname = "c_" 
         elsif (level_type == 'int')
           style = " style='background-color: #FFFFFF;' "
           fieldname = "i_"
         elsif (level_type == 'avail')
           style = " style='background-color: #C6D9F1;' "
           fieldname = "a_"
         end
         lowlevel = fieldname + "low"
         modlevel = fieldname + "mod"
         highlevel= fieldname + "high"
         
            level = "<td #{style}>#{impact_level[lowlevel]}</td><td #{style}>#{impact_level[modlevel]}</td><td #{style}>#{impact_level[highlevel]}</td>"
         
          return level
       end
       
       
       
    def grab_levels2(impact_levels, the_view, details)
        info = ""
        il = false
        if (the_view == "impact_levels")
          il = true
        end
         if has_data?(impact_levels)
           rstyle = " style='background-color: #F2DBDB; text-align: center;'"
           wstyle = " style='background-color: #FFFFFF; text-align: center;'"
           bstyle = " style='background-color: #C6D9F1; text-align: center;'"
           info = "<table style='border-spacing: 10px;'><thead><tr>"
           if (il)
             info = info + "<th></th><th></th>"
           end
           info = info + "<th></th>"
             
           info = info + "<th colspan='3' width='100px' #{rstyle}> Confidentiality </th>
             <th colspan='3' width='100px' #{wstyle}> Integrity </th><th colspan='3' width='100px' #{bstyle}> Availability </th></thead></tr>"
           if (il)
             if (details == "full")
               info = info + "<td>Control ID</td><td>Domain</td><td>Version</td>"
             elsif (details == "domain")
               info = info + "<td>Domain</td><td>Controls</td><td>Version</td>"
             end
           end
           rstyle = " style='background-color: #F2DBDB;'"
           wstyle = " style='background-color: #FFFFFF;'"
           bstyle = " style='background-color: #C6D9F1;'"
           info = info + "<td><b>Provider</b></td><td #{rstyle}><b>L</b></td><td #{rstyle}><b>M</b></td><td #{rstyle}><b>H</b></td> "
           info = info + "<td #{wstyle}><b>L</b></td><td #{wstyle}><b>M</b></td><td #{wstyle}><b>H</b></td> "
           info = info + "<td #{bstyle}><b>L</b></td><td #{bstyle}><b>M</b></td><td #{bstyle}><b>H</b></td> "
             impact_levels.each do |impact_level|
               provider = "not set"
               if (impact_level.provider != nil)
                 provider = impact_level.provider.name
               end
               conf = convert_impact_level('conf',impact_level)
               integ = convert_impact_level('int',impact_level)
               avail = convert_impact_level('avail',impact_level)
               version = impact_level.grab_version
               info  = info  +  "<tr>"
               if (il)
                 if (details == "full")
                   if (impact_level.security_control != nil)
                     info = info + "<td>#{impact_level.security_control.the_url}</td><td></td>"
                   elsif (impact_level.domain_environment != nil)
                     info = info + "<td></td><td>#{impact_level.domain_environment.name}</td>"
                   end
                 elsif (details == "domain")
                   info = info + "<td>#{impact_level.domain_environment.name}</td><td>
                     <a href='/impact_levels/#{impact_level.id}/show_controls/'</a> Show Controls (#{impact_level.grab_controls_count})</td>"
                 end
               info = info + "<td>#{version}</td>"
               end
               info  = info  +  "<td>#{provider}</td>#{conf}#{integ}#{avail}"
               info  = info  +  "<td><a href='/impact_levels/#{impact_level.id}/'</a>Show </td>"
               if (details == "domain")
                 info  = info  +  "<td><a href='/impact_levels/#{impact_level.id}/edit/'</a>Edit </td>"
               end
               info  = info  +  "<td><a data-confirm='Are you sure?' data-method='delete' 
                 href='/impact_levels/#{impact_level.id}/' rel='nofollow'>Delete</a></td></tr>"
               
             end
           info  = info  +  "</table>"
           end
            
           return info.html_safe
      end
      
    def grab_statements(the_parent)
        count = 1
        statements = ""
        if (the_parent.statements != nil)
          the_statements = the_parent.statements
          check_these = []
           if (the_statements.class == Statement)
             check_these  << the_statements
           else
             check_these = the_statements 
           end
           
            if has_data?(check_these)
              statements = "<ul>"
              check_these.each do |statement|
                statements = statements + "<li><a href='/statements/#{statement.id}'>#{statement.description}</a> "
                count = count +1
                if (statement.items.size > 0)
                   statements = statements + grab_the_items(statement)
                end
                statements = statements + "</li>"  + grab_ref_urls_for(RelatedRef.grab_refs_by_type(statement, "owner", "corresp"))
              end
              statements = statements + "</ul>" 
              end
          end
         return statements.html_safe
    end
    def grab_assessments(the_parent)
          assessments = ""
        
        if has_data?(the_parent.assessments)
          assessments = "<ul>"
          the_parent.assessments.each do |assessment|
            assessments = assessments + "<li><a href='/assessments/#{assessment.id}'>#{assessment.method}</a>"
            if (assessment.assessment_objects.size > 0)
              assessments = assessments + grab_assessment_objects(the_parent)
            end
            assessments = assessments + "</li>" + grab_ref_urls_for(RelatedRef.grab_refs_by_type(assessment, "owner", "corresp"))
          end
          assessments = assessments + "</ul>" 
        end
      
      return assessments.html_safe
      end
    
      def grab_references_articles(object)
      the_urls = "<ul>"
      references =RelatedRef.grab_refs_by_type(object, "reference", "owner")
      if has_data?(references)
        references.each do |the_related_ref| 
          the_urls = the_urls + "<li>#{the_related_ref.grab_related_object_url}</li>"
        end
      end
      the_urls = the_urls + "</ul>"
      return the_urls.html_safe
    end
    
    
      def grab_assessment_objects(the_parent)
        assessment_objects = ""
        count = 1
        level = 1
        if has_data?(the_parent.assessment_objects)
            assessment_objects = "<ul>"
          the_parent.assessment_objects.each do |assessment_object|
              assessment_objects = assessment_objects + "<li>
              <a href='/assessment_objects/#{assessment_object.id}'>#{convert_level(count, level)}#{assessment_object.description} </a></li>
              "+ grab_ref_urls_for(RelatedRef.grab_refs_by_type(assessment_object, "owner", "corresp"))
              count = count +1
            end
            assessment_objects = assessment_objects + "</ul>"
        end 
        
         return assessment_objects.html_safe
      end    
     
      def grab_related_controls(object)
     references = RelatedRef.grab_refs_by_type(object, "related", "owner") 
     info = ""
     if has_data?(references)
       info = "<br>| "
       references.each do |ref|
         the_sc = SecurityControl.find(ref.object_id)
         info = info + the_sc.the_url + " | "
       end
      
     end
     return info.html_safe 
    end
    
      def grab_guidances(the_parent)
        
        guidances = ""
        if has_data?(the_parent.guidances)
          guidances = "<ul>"
          the_parent.guidances.each do |guidance|
            guidances = guidances + "<li><a href='/guidances/#{guidance.id}'>View </a>-#{guidance.description}</li>"  
            controls = grab_related_controls(guidance)
            if has_data?(controls)
              guidances = guidances +"<strong>Related Controls:</strong>" +   controls
            end
          end
          guidances = guidances + "</ul>"
          
        end 
        return guidances.html_safe
      end
    def create_objective_array(the_objectives)
        all_objectives = []
        the_objectives.each do |curent_objective|
          objective_id = curent_objective.objective_id 
          name = curent_objective.grab_name
          description = curent_objective.description
          id = curent_objective.id
          security_control_id = curent_objective.security_control_id
          parent_id = curent_objective.parent_id
          all_objectives.push({parent_id: parent_id, id: id, security_control_id: security_control_id, 
            description: description, name: name, objective_id: objective_id, curent_objective: curent_objective})
        end
        return all_objectives
      end
      
      def create_objective_list(all_objectives, parent_objective, the_parent, level)
        objectives = "<ul>"
        counter = 1
        
        #if parent_objective != nil
          
        all_objectives.each do |objective|
          
          if (objective[:parent_id] == parent_objective)
            name = ""
            if (objective[:name] != nil)
              name = "#{objective[:name]}"
            end
            if (objective[:description] != nil)
              description = objective[:description]
            else
              description = "See child elements"
            end
            
            objectives = objectives + "<li><a href='/objectives/#{objective[:id]}' title='#{name}'>
              #{convert_level(counter, level)} #{description} </a> </li>" 
            counter  = counter + 1
            child_objectives = []
            child_objectives = all_objectives.select { |hash_element| hash_element[:parent_id] == objective[:id]}
            if (child_objectives.size > 0)
              objectives = objectives + "<ul>"
              objectives = objectives + create_objective_list(all_objectives, objective[:id], the_parent, (level+1))
              objectives = objectives + "</ul>"
            end
          end
        end
        objectives = objectives + "</ul>"
          return objectives
        end
        
        def grab_objectives(the_parent)
          all_objectives = create_objective_array(the_parent.objectives)
          objectives = create_objective_list(all_objectives, nil, the_parent, 1)
          return objectives.html_safe
        end
      
       def show_child_objectives(the_parent)
          child_objectives = the_parent.children
          all_objectives = create_objective_array(child_objectives)
          objectives = create_objective_list(all_objectives, the_parent.id, the_parent,1)
          return objectives.html_safe
        end
        
      
       def grab_the_items(statement)
         items = ""
        parent_id = nil
        theitems = statement.items
        
        first = true
        counter = 1
        level = 2
        if has_data?(theitems)
          items = "<ul>"
          items = grab_item(theitems, 2, statement)
          items = items + "</ul>"
            
           end 
           
           return items.html_safe
       end
       
       def grab_item(the_items, level, statement)
         counter = 1
         items = ""
       the_items.each do |item|
          position = convert_level(counter, level)
          items = items + "<li><a href='/items/#{item.id}'title='#{item.item_id}' >#{position} #{item.description}</a>"
          counter  = counter + 1
          child_items = item.children
         if (child_items.size > 0)
           childlevel = level + 1
           items = items + "<ul>"
           items = items + grab_item(child_items, childlevel, statement)
           items = items + "</ul></li>"
           end  
         end
         return items
       end
            
       
       def grab_params(the_parent)
         the_rows = ""
         if has_data?(the_parent.params)
           the_rows = "<table >
                         <thead>
                           <tr>
                             <th style='text-align: center;'>Param ID</th>
                             <th style='text-align: center;'>Description</th>
                             <th style='text-align: center;'>Selection Type</th>
                             <th style='text-align: center;'>Values</th>
                            </tr>
                          </thead>"  
           parent_params = the_parent.params.where(parent: nil)
           
           the_rows = the_rows + grab_param_row(parent_params, the_parent)
           
           the_rows = the_rows + "</table>"
         end 
         return the_rows.html_safe
       end
       
       def grab_param_row(params, the_parent)
         the_row = ""
       params.each do |param|
         child_params = Param.where(parent: param)
         parent = ""
         if (param.parent == nil)
           parent = "<a href='/params/#{param.id}'><i class=\"fa fa-external-link\"> #{param.params_id}</i></a>"
         end
         
         the_row = the_row  + "<tr><td>#{parent}</td>
             <td>#{param.description}</td>
             <td>#{param.selection_type}</td>
             <td>#{param.grab_values}"
         
           if param.selection_type == nil 
             
              the_row = the_row  + " - #{param.value_url}" 
           end
           the_row = the_row  + "</td> </tr>"
                 
           if (child_params.size > 0)
             the_row = the_row + grab_param_row(child_params, the_parent)
           end
         end
         return the_row
       end
         
    def grab_objects_abv_url(the_objects)
        object_names= ""
    if (the_objects.size == 0)
      return nil
    else
      the_objects.each do |the_object|
        object_names =object_names + " " + "<%= link_to '#{the_object.abv}', #{the_object} %>"
      end
      return object_names.html_safe
      end
    end
   
   
    def grab_security_controls
      if (self.security_controls.present?)
       return the_url_links_by_field(objects)
      else 
        return nil
      end
    end
    
 
     
     
   
   def grab_ref_urls_for(refs)
    info = ""
   if has_data?(refs)
     refs.each do |ref|
       info = info + "| " +  ref.the_url
       end
     end 
     return info 
   end
end
