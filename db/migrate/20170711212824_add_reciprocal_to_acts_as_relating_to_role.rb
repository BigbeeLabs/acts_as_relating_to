class AddReciprocalToActsAsRelatingToRole < ActiveRecord::Migration[4.2]
  def change
    add_column :acts_as_relating_to_roles, :reciprocal, :string
  end
end
