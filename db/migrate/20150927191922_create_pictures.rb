class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :url
      t.string :secure_url
      t.string :public_id

      t.timestamps null: false
    end
  end
end
