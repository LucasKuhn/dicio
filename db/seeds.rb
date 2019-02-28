File.open("words.txt", "r").each_line do |line|
  word, classification = line.delete("\n").split('/')
  sorted_word = word.split('').sort.join('')
  Word.create(
    name:word,
    sorted_word: sorted_word,
    classification:classification
  )
end
