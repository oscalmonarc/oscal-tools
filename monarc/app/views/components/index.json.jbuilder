json.set! :data do
  json.array! @components do |component|
    json.partial! 'components/component', component: component
    json.url  "
              #{link_to 'Show', component }
              #{link_to 'Edit', edit_component_path(component)}
              #{link_to 'Destroy', component, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end