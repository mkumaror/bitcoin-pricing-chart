class CreatePricings < ActiveRecord::Migration[5.2]
  def change
    create_table :pricings do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.jsonb :data, null: false, default: {}

      t.timestamps
    end
  end
end
