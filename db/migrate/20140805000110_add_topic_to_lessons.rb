class AddTopicToLessons < ActiveRecord::Migration
  def change
  	add_column :lessons, :topic, :string
  end
end
