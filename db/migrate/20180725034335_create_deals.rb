class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
    	t.integer :wins_remaining
      t.integer :odds_numerator
      t.integer :odds_denominator
      t.string :description

      t.belongs_to :company
      t.timestamps
    end
  end
end
