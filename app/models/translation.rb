class Translation < ApplicationRecord

  # scopes here

  # IMPROVE FUNCTION NAMES

  # # Takes a translation, traverses input::String, calls translate_word on each word in string
  def to_pig_latin
    # words = self.input.split(" ")
    self.translation = "pig latinzied string"
  end

  # # translates a word to pig latin
  # def translate_word
  # end

  # # checks if given char is alphanumeric
  # def letter?
  # end

  # def vowel?
    # we count Y, see prompt
  # end

  # def consonant?
  # end

  # some possible extensions.....
  # def to_french
  # end

  # def to_german
  # end

end
