json.set! :data do
  json.array! @overlays do |overlay|
    json.partial! 'overlays/overlay', overlay: overlay
    json.url  "
              #{link_to 'Show', overlay }
              #{link_to 'Edit', edit_overlay_path(overlay)}
              #{link_to 'Destroy', overlay, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end