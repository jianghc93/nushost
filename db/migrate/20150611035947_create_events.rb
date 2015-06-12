class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :host, null: false
      t.text :description, null: false
      t.string :summary, null: false
      t.date :date, null: false
      t.time :time, null: false
      t.timestamps null: false
    end
  end
end
