class Word < ApplicationRecord
  validates :name, :presence => true
  scope :starting_with, -> (letter) { where("lower(name) LIKE '#{letter}%'") }
  scope :numbers, -> { where(classification: 'number') }
  def to_regex
    str = ""
    sorted_word.chars.each {|char| str << ".*#{char}{1}"}
    Regexp.new str
  end
end
