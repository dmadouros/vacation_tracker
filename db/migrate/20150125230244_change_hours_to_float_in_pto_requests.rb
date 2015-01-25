class ChangeHoursToFloatInPtoRequests < ActiveRecord::Migration
  def change
    change_column :pto_requests, :hours, :float
  end
end
