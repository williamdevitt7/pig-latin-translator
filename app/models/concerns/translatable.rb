module Translatable
  extend ActiveSupport::Concern

  included do 
    scope :ordered, -> { order(created_at: :desc) }
    scope :pig_latin, -> { where(language: "pig_latin") }
  end

  PIG_LATIN_REGEX    = /^([^aeiou]*)(.*)/ 
  PUNCTUATION_REGEX  = /[.…!?;:><\\-]/      # add other any punctuation you wish to handle here.
  ALPHABET_REGEX     = /[[:alpha:]]/
  UPPERCASE_REGEX    = /[[:upper:]]/

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
  
end
