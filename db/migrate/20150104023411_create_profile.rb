class CreateProfile < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.datetime :hired_on
    end
  end
end
