class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
  	  t.string :name null: false
      t.string :identity_url null: false
      t.timestamps null: false
    end
  end
end
