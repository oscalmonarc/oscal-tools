class LabelsDatatable < AjaxDatatablesRails::Base

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      
       name: { source: "Label.name", cond: :like }, 
       children: { source: "Label.children", cond: :filter_children_condition },
       components: { source: "Label.components", cond: :filter_components_condition },
    }
  end

  def data
    records.map do |record|
      {
        # example:
         id: record.id,
         name: record.name,
         children: record.children,
         components: record.components
      }
    end
  end

  private

  def get_raw_records
    Label.select('labels.*').includes(:related_labels)
  end

  # ==== These methods represent the basic operations to perform on records
  # and feel free to override them

   def filter_children_condition
     ->(column) { column.table[column.field].eq(column.search.value.to_i + 1) }
   end
   
   def filter_components_condition
     ->(column) { column.table[column.field].eq(column.search.value.to_i + 1) }
   end

  # def sort_records(records)
  # end

  # def paginate_records(records)
  # end

  # ==== Insert 'presenter'-like methods below if necessary
end
