json.set! :data do
  json.array! @overlay_field_options do |overlay_field_option|
    json.partial! 'overlay_field_options/overlay_field_option', overlay_field_option: overlay_field_option
    json.url  "
              #{link_to 'Show', overlay_field_option }
              #{link_to 'Edit', edit_overlay_field_option_path(overlay_field_option)}
              #{link_to 'Destroy', overlay_field_option, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end