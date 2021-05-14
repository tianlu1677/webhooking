class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.integer :user_id, null: false
      t.string :uuid, null: false

      t.timestamps
    end

    add_index :accounts, :user_id
    add_index :accounts, :uuid
  end
end
