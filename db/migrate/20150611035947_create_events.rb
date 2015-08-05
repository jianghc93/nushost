class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :host, null: false
      t.string :summary, null: false
      t.string :venue, null: false
      t.text :description, null: false
      t.datetime :time, null: false
      t.string :lat
      t.string :lng
      t.timestamps null: false
    end
  end
end
