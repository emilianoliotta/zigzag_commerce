class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :positive
      t.integer :negative
      t.integer :inappropriate

      t.timestamps null: false
    end
  end
end
