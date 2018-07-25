class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
    	t.integer :wins_remaining
      t.decimal :winning_odds
      t.string :description

      t.belongs_to :company
      t.timestamps
    end
  end
end
