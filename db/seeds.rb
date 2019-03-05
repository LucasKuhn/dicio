File.open("words.txt", "r").each_line do |line|
  word, classification = line.delete("\n").split('/')
  sorted_word = I18n.transliterate(word).chars.sort.join
  Word.create(
    name:word,
    sorted_word: sorted_word,
    classification:classification
  )
end
