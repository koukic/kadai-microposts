class AddUserToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_column :microposts, :user, :string
    add_column :microposts, :string, :string
  end
end
