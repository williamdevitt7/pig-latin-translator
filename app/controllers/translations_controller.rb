class TranslationsController < ApplicationController

  def index
    @all_translations = Translation.all
  end

  # because this application is simple, and we only deal with "new" Translations, I will encompass 
  # the display of all Translations within the new page.
  def new
    @translation = Translation.new(language: "pig_latin")
    # we'll display all past Translations adjacent to the input box, which is also where we will 
    # display the current Translation result .
    @all_translations = Translation.all.reverse 
  end

  def create 
    # no need for globals in our create method - save some memory
    translation = Translation.new(translation_params)

    # Main function. Sets Translation.translation to the translated input
    # translation.to_pig_latin 
    if translation.save
      redirect_to index_path
    else
      flash[:error] = "Translation not processed!"
      render :new
    end
  end

  private
    def translation_params
      params.require(:translation).permit(:language, :input, :translation)
    end

end
