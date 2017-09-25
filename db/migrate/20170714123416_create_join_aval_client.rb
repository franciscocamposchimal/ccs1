class CreateJoinAvalClient < ActiveRecord::Migration[5.1]
  def change
  	create_join_table :avals, :clients do |t|
      t.index [:aval_id, :client_id]
    end
  end
end
