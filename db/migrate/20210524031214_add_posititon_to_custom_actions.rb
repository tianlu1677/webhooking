class AddPosititonToCustomActions < ActiveRecord::Migration[6.1]
  def change
    remove_column :custom_actions, :sort
    add_column :custom_actions, :position, :integer
  end
end
