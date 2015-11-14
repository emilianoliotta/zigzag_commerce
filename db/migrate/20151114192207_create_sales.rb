class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :first_name
      t.string :last_name
      t.integer :area_code
      t.integer :number
      t.string :zip_code
      t.string :street
      t.integer :street_number
      t.string :preference_id
      t.string :payment_id
      t.text :description

      t.timestamps null: false
    end
  end
end
