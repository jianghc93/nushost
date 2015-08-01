class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.belongs_to :event, index: true
      t.belongs_to :user, index: true
      t.string :role
      t.timestamps null: false
    end
  end
end
