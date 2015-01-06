class CreatePtoRequests < ActiveRecord::Migration
  def change
    create_table :pto_requests do |t|
      t.references :user, index: true
      t.date :start_date
      t.date :end_date
      t.integer :hours
    end
  end
end
