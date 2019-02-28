class AddSortedWordToWords < ActiveRecord::Migration[5.2]
  def change
    add_column :words, :sorted_word, :string
  end
end
