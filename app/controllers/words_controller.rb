class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  # GET /words
  # GET /words.json
  def index
    firt_letter = params[:firt_letter] ? params[:firt_letter] : 'a'
    @words = Word.starting_with(firt_letter)
    @json = @words.map{ |word| word.name }
  end

  def anagram
    search = params[:search]
    @words = []
    sorted = I18n.transliterate(search).chars.sort.join
    Word.where(sorted_word:sorted).each do |word|
      @words << word.name
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
          @words << "#{number.name} #{word.name} "
        end
      end
    end
    render json: @words
  end

  def scrabble
    search = params[:search]
    @words = []
    sorted = I18n.transliterate(search).chars.sort.join
    Word.all.each do |word|
      if sorted.match(word.to_regex)
        @words << word.name
      end
    end
    render json: @words
  end

  def find_numbers
    search = params[:search]
    @words = []
    sorted = I18n.transliterate(search).chars.sort.join
    Word.numbers.each do |word|
      if sorted.match(word.to_regex)
        @words << word.name
      end
    end
    render json: @words
  end

  def charade
    letters = params[:search].split("-")
    @words = []
    Word.all.each do |word|
      next if word.name.length < letters.size
      possible_word = true
      word.name.chars.each_with_index do |letter,index|
        next unless letters[index]
        unless letters[index].include?(letter)
          possible_word = false
        end
      end
      if possible_word
        @words << word.name
      end
    end
    render json: @words
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.fetch(:word, {})
    end
end
