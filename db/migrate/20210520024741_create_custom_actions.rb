class CreateCustomActions < ActiveRecord::Migration[6.1]
  def change
    create_table :custom_actions do |t|
      t.string :title
      t.string :description
      t.string :custom_action
      t.references :webhook, null: false, foreign_key: true
      t.string :category
      t.integer :sort
      t.jsonb :input_dict

      t.timestamps
    end
  end
end
