class CreateDummies < ActiveRecord::Migration
  def change
    create_table :dummies do |t|
      t.text :success
      t.text :failure
      t.text :pending
      t.string :payment_id

      t.timestamps null: false
    end
  end
end
