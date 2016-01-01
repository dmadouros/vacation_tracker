class AddPtoRequestSortDirectionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pto_request_sort_direction, :string, default: 'asc'
  end
end
