class Translation < ApplicationRecord

  PIG_LATIN_REGEX    = /^([^aeiou]*)(.*)/ 
  PUNCTUATION_REGEX  = /[.!?;:\\-]/
  ALPHABET_REGEX     = /[[:alpha:]]/
  UPPERCASE_REGEX    = /[[:upper:]]/

  scope :ordered, -> { order(created_at: :desc) }
  scope :pig_latin, -> { where(language: "pig_latin") }

  validates :input, presence: true

  def to_pig_latin
    words = self.input.split(" ")
    translated_str = ""
    words.each do |word|
      translated_str += translate(word) + " "
    end
    self.translation = translated_str.strip
  end

  # possible extensions...
  # def to_french
    # etc...
  # end

  private

    def translate word
      uppercases = get_uppercase_indicies(word)
      punctuation = get_punctuation(word)
      word.gsub!(PUNCTUATION_REGEX, '')
      word.downcase!
      if vowel?(word.first)
        word = capitalize(uppercases, word)  
        suffix = uppercase?(word.last) ? "WAY" : "way"
      else 
        word.gsub!("qu", " ") # handle the strange qu vowel sound edge case by removing and adding it on the end.
        word.gsub!(PIG_LATIN_REGEX,'\2\1')
        word.gsub!(" ", "qu") 
        word = capitalize(uppercases, word)
        suffix = uppercase?(word.last) ? "AY" : "ay" 
      end
      return word + suffix + punctuation
    end

    def get_uppercase_indicies word
      uppercases = []
      word.each_char.with_index { |c, i| uppercases.append(i) if uppercase?(c) }
      return uppercases
    end

    def get_punctuation word
      return word.scan(PUNCTUATION_REGEX).join
    end

    def vowel? c
      return ['a','e','i','o','u','y'].include?(c.downcase) && letter?(c)
    end

    def letter? c
      return c.match?(ALPHABET_REGEX)
    end

    def uppercase? c
      return c.match?(UPPERCASE_REGEX)
    end

    def capitalize indexes, word
      indexes.each do |i|
        word[i] = word[i].upcase
      end
      return word
    end
 
end
