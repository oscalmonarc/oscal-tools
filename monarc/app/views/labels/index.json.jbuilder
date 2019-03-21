json.set! :data do
  json.array! @labels do |label|
    json.partial! 'labels/label', label: label
    json.url  "
              #{link_to 'Show', label }
              #{link_to 'Edit', edit_label_path(label)}
              #{link_to 'Destroy', label, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end