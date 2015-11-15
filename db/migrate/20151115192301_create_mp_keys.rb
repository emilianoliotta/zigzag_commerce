class CreateMpKeys < ActiveRecord::Migration
  def change
    create_table :mp_keys do |t|
      t.string :client_id
      t.string :client_secret
      t.string :public_key
      t.string :access_token
      t.boolean :sandbox

      t.timestamps null: false
    end
  end
end
