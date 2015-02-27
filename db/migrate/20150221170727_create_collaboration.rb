class CreateCollaboration < ActiveRecord::Migration
  def change
    create_table :collaborations do |t|
      t.references :user, index: true
      t.references :wiki, index: true
    end
  end
end
