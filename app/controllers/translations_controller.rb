class TranslationsController < OpenApiController

  # GET /translations
  def index
    @translation = Translation.new(language: "pig_latin")
    @all_translations = Translation.pig_latin.ordered.first(15)

    render json: @all_translations
  end

  # GET /translations/:id
  def show 
    @translation = Translation.find(params[:id])
    render json: @translation
  end

  def create
    translation = Translation.new(translation_params)
    translation.translate
    if !translation.save
      flash[:error] = "Translation not processed! Make sure to enter some input."
    end
    redirect_to root_path
  end

  protected

    def translation_params
      params.require(:translation).permit(:language, :input, :translation)
    end

end
