class AddTutorColumnToUsersTable < ActiveRecord::Migration
  def change
  	add_column :users, :tutor, :boolean
  end
end
