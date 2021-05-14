class CreateAccountTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :account_tokens do |t|
      t.string :uuid
      t.string :receive_email
      t.datetime :expired_at
      t.integer :account_id

      t.timestamps
    end
  end
end
