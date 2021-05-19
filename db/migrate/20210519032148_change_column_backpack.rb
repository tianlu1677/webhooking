class ChangeColumnBackpack < ActiveRecord::Migration[6.1]
  def change
    remove_column :backpacks, :req_params
    remove_column :backpacks, :json_params
    remove_column :backpacks, :content

    add_column :backpacks, :content_type, :string
    add_column :backpacks, :media_type, :string
    add_column :backpacks, :raw_content, :text
  end
end
