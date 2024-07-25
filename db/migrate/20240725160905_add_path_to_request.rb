class AddPathToRequest < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :path, :string
  end
end
