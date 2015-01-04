class AddPtoHoursUsedToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :pto_hours_used, :integer
  end
end
