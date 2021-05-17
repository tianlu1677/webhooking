class AddContentLengthToBackpack < ActiveRecord::Migration[6.1]
  def change
    add_column :backpacks, :content_length, :integer, default: 0
  end
end
