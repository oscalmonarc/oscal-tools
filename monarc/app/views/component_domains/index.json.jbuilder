json.set! :data do
  json.array! @component_domains do |component_domain|
    json.partial! 'component_domains/component_domain', component_domain: component_domain
    json.url  "
              #{link_to 'Show', component_domain }
              #{link_to 'Edit', edit_component_domain_path(component_domain)}
              #{link_to 'Destroy', component_domain, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end