require "test_helper"

class TranslationControllerTest < ActionDispatch::IntegrationTest
  test "view root page" do
    get '/'
    assert_response :success
  end

  test "create translation" do 
    translation = Translation.new(language: "english", input: "hello world", translation: "hello world")
    translation.to_pig_latin
    assert translation.save, "Created test translation"
  end

end
