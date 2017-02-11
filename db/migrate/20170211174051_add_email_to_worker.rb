class AddEmailToWorker < ActiveRecord::Migration[5.0]
  def change
    add_column :workers, :email, :string
  end
end
