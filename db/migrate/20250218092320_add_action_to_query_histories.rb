class AddActionToQueryHistories < ActiveRecord::Migration[8.0]
  def change
    add_column :query_histories, :action, :string
  end
end
