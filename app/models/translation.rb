class Translation < ApplicationRecord
  include Translatable

  validates :input, length: { minimum: 1, maximum: (2**31 - 1) }

  def to_pig_latin
    words = self.input.split(" ")
    translated_str = ""
    words.each do |word|
      translated_str += pig_latinize(word) + " "
    end
    self.translation = translated_str.strip
  end

  private

    def pig_latinize word
      uppercases = get_uppercase_indicies(word)
      punctuation = get_punctuation(word)
      word.gsub!(PUNCTUATION_REGEX, '')
      word.downcase!
      if vowel?(word.first)
        suffix = "way"
      else 
        word.gsub!("qu", " ") # handle the strange qu vowel sound edge case by removing and adding it on the end.
        word.gsub!(PIG_LATIN_REGEX,'\2\1')
        word.gsub!(" ", "qu") 
        suffix = "ay" 
      end
      word = maintain_capitalization(uppercases, word)  
      suffix.upcase! if uppercase?(word.last) && word.length > 1
      return word + suffix + punctuation
    end

    def get_uppercase_indicies word
      uppercases = []
      word.each_char.with_index { |c, i| uppercases.append(i) if uppercase?(c) }
      return uppercases
    end

    def maintain_capitalization indicies, word
      indicies.each do |i|
        word[i] = word[i].upcase
      end
      return word
    end
 
end
