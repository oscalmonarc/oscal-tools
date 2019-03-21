class FixDBtoInnoDb < ActiveRecord::Migration[5.2]
   def self.table_engine(table, engine='InnoDB')
     execute "ALTER TABLE `#{table}` ENGINE = #{engine}"
   end

   def self.up
     theTables = ActiveRecord::Base.connection.tables
     theTables.each do  |thisTable|
        table_engine thisTable, 'InnoDB'
     end

   end

   def self.down
     theTables = ActiveRecord::Base.connection.tables
     theTables.each do  |thisTable|
       table_engine thisTable, 'MyISAM'
     end
   end
end
