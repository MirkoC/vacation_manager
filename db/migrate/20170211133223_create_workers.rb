class CreateWorkers < ActiveRecord::Migration[5.0]
  def change
    create_table :workers do |t|
      t.string :full_name
      t.string :image

      t.timestamps
    end
  end
end
