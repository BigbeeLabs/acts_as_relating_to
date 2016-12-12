class CreateActsAsRelatingToRoles < ActiveRecord::Migration
  def change
    create_table :acts_as_relating_to_roles do |t|
      t.string :name
      t.string :display_name

      t.timestamps null: false
    end
  end
end
