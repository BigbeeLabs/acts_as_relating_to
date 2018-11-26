class CreateActsAsRelatingToRelationshipInvitations < ActiveRecord::Migration[4.2]
  def change
    create_table :acts_as_relating_to_relationship_invitations do |t|
      t.integer :sender_id
      t.string :sender_type
      t.integer :recipient_id
      t.string :recipient_type
      t.integer :status, default: 0
      t.integer :role_id

      t.timestamps null: false
    end
  end
end
