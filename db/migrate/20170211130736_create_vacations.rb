class CreateVacations < ActiveRecord::Migration[5.0]
  def change
    create_table :vacations do |t|
      t.references :vacationable, polymorphic: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
