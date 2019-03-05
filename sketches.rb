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

def sort_for_regex(string)
  str = ""
  string.chars.sort.each {|char| str << ".*#{char}{1}"}
  Regexp.new str
end

numbers.each do |number|
end

def search_for(string)
  sorted = I18n.transliterate(string).chars.sort.join
  Word.where(sorted_word:sorted).each do |word|
    p word.name
  end
  Word.numbers.each do |number|
    if sorted.match(number.to_regex)
      p "ENCONTROU: #{number.name}"
      chars = sorted.chars
      number.sorted_word.chars.each do |char|
         chars.delete_at(chars.index(char) || chars.length)
      end
      new_search = chars.join
      Word.where(sorted_word:new_search).each do |word|
        p "#{number.name} #{word.name} "
      end
    end
  end
  return nil
end

search = "dois aneis"
search = "sienasiod"
sorted_search = search.chars.sort.join
number = "dois".chars.sort.join
regex_string = ""
number.split('').each {|char| regex_string << ".*#{char}{1}"}
if sorted_search.match(Regexp.new regex_string)
  p "horay!"
else
  p "nay"
end
