require "test_helper"

class TranslationTest < ActiveSupport::TestCase

  # These specific tests were given to me in the prompt.
  test "convert sentence to Pig Latin" do
    english_input = [ "are", "eat", "hello", "eat", "yellow", "eat world", "Hello", "Apples", "eat... world?!",
                      "school", "quick", "she's great!", "HELLO", "Hello There" ] 
                      
    pig_latin = [ "areway", "eatway", "ellohay", "eatway", "yellowway", "eatway orldway", "Ellohay", "Applesway", 
                  "eatway... orldway?!", "oolschay", "ickquay", "e'sshay eatgray!", "ELLOHAY", "Ellohay Erethay" ]
    
    english_input.each_with_index do |english_word, i|
      t = Translation.new(language: "pig_latin", input: english_word)
      t.translation = t.to_pig_latin
      assert_equal pig_latin[i], t.translation
    end
  end 

end
