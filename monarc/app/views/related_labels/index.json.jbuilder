json.set! :data do
  json.array! @related_labels do |related_label|
    json.partial! 'related_labels/related_label', related_label: related_label
    json.url  "
              #{link_to 'Show', related_label }
              #{link_to 'Edit', edit_related_label_path(related_label)}
              #{link_to 'Destroy', related_label, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end