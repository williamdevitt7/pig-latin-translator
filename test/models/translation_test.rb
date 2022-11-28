require "test_helper"

class TranslationTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "convert sentence to Pig Latin" do
    english_input = [ "hello", "eat", "yellow", "eat world", "Hello", "Apples", "eat... world?!",
                      "school", "quick", "she's great!", "HELLO", "Hello There" ] 
    pig_latin = [ "ellohay", "eatway", "yellowway", "eatway orldway", "Ellohay", "Applesway", "eatway... orldway?!",
                  "oolschay", "ickquay", "e’sshay eatgray!", "ELLOHAY", "Ellohay Erethay" ]

    0.upto(english_input.length) do |i|
      t = Translation.new(language: "pig_latin", input: english_input[i])
      t.translation = t.to_pig_latin
      assert_equal pig_latin[i], t.translation
    end
  end 

end
