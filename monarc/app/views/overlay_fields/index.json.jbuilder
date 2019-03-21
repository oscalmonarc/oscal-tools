json.set! :data do
  json.array! @overlay_fields do |overlay_field|
    json.partial! 'overlay_fields/overlay_field', overlay_field: overlay_field
    json.url  "
              #{link_to 'Show', overlay_field }
              #{link_to 'Edit', edit_overlay_field_path(overlay_field)}
              #{link_to 'Destroy', overlay_field, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end