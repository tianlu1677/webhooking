class AddQueryParamsToBackpack < ActiveRecord::Migration[6.1]
  def change
    add_column :backpacks, :query_params, :jsonb
    add_column :backpacks, :form_params, :jsonb
    add_column :backpacks, :json_params, :jsonb
  end
end
