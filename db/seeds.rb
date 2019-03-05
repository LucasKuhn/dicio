File.open("words.txt", "r").each_line do |line|
  word, classification = line.delete("\n").split('/')
  sorted_word = I18n.transliterate(word).chars.sort.join
  Word.create(
    name:word,
    sorted_word: sorted_word,
    classification:classification
  )
end

numbers = [
"zero",
"um",
"dois",
"três",
"quatro",
"cinco",
"seis",
"sete",
"oito",
"nove",
"dez",
"onze",
"doze",
"treze",
"quatorze",
"catorze",
"quinze",
"dezesseis",
"dezessete",
"dezoito",
"dezenove",
"vinte"
]

numbers.each do |number|
  word = Word.find_by(name:number)
  word.update(classification:'number')
end
