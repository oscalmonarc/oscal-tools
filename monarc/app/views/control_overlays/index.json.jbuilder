json.set! :data do
  json.array! @control_overlays do |control_overlay|
    json.partial! 'control_overlays/control_overlay', control_overlay: control_overlay
    json.url  "
              #{link_to 'Show', control_overlay }
              #{link_to 'Edit', edit_control_overlay_path(control_overlay)}
              #{link_to 'Destroy', control_overlay, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end