class AddContentToSheets < ActiveRecord::Migration[7.0]
  def change
    add_column :sheets, :content, :string
  end
end
