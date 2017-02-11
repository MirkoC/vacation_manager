class AddPersonalizedDataToManager < ActiveRecord::Migration[5.0]
  def change
    add_column :managers, :full_name, :string
    add_column :managers, :image, :string
  end
end
