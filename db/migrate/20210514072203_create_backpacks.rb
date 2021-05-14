class CreateBackpacks < ActiveRecord::Migration[6.1]
  def change
    create_table :backpacks do |t|
      t.string :uuid
      t.string :url
      t.string :req_method
      t.string :ip
      t.string :hostname
      t.string :user_agent
      t.string :referer
      t.text :content
      t.jsonb :headers
      t.integer :status_code
      t.jsonb :req_params

      t.integer :account_id
      t.string :token_uuid

      t.timestamps
    end
  end
end
