class CreateActsAsRelatingToRelationships < ActiveRecord::Migration
  def change
    create_table :acts_as_relating_to_relationships do |t|
      t.integer :owner_id
      t.string :owner_type
      t.integer :in_relation_to_id
      t.string :in_relation_to_type

      t.timestamps null: false
    end
  end
end
