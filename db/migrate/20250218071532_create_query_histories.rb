class CreateQueryHistories < ActiveRecord::Migration[8.0]
  def change
    create_table :query_histories do |t|
      t.string :domain_name
      t.string :query_type

      t.timestamps
    end
  end
end
