class CreateInformation < ActiveRecord::Migration[5.1]
  def change
    create_table :information do |t|
      t.string :city
      t.date :start_date
      t.date :end_date
      t.float :price
      t.string :status
      t.string :color

      t.timestamps
    end
  end
end
