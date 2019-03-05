class Word < ApplicationRecord
  validates :name, :presence => true
  scope :starting_with, -> (letter) { where("lower(name) LIKE '#{letter}%'") }
  scope :numbers, -> { where(classification: 'number') }
  before_create :set_sorted_word
  def set_sorted_word
    self.sorted_word = I18n.transliterate(self.name).chars.sort.join
  end
  def to_regex
    str = ""
    sorted_word.chars.each {|char| str << ".*#{char}{1}"}
    Regexp.new str
  end
end
