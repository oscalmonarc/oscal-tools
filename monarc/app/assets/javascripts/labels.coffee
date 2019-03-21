# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class App.Labels extends App.Base

 index: ->
    $ ->
      $('#dataTable').dataTable
        ajax: Routes.cities_index_path()
        columns: [
            data: "name"
          ,
            data: "children"
          ,
            data: "components"
        ]