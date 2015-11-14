class RemoveDummy < ActiveRecord::Migration
  def change
  	drop_table :dummies
  end
end
