json.set! :data do
  json.array! @control_implementations do |control_implementation|
    json.partial! 'control_implementations/control_implementation', control_implementation: control_implementation
    json.url  "
              #{link_to 'Show', control_implementation }
              #{link_to 'Edit', edit_control_implementation_path(control_implementation)}
              #{link_to 'Destroy', control_implementation, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end