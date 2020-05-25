class PoemsController < ApplicationController
  before_action :set_poem, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_permission, only: [:edit, :update, :destroy]

  # GET /poems
  # GET /poems.json
  def index
    @pagy, @poems = pagy(Poem.all, items:9)
  end

  # GET /poems/1
  # GET /poems/1.json
  def show
  end

  # GET /poems/new
  def new
    @poem = Poem.new
  end

  # GET /poems/1/edit
  def edit
  end

  # POST /poems
  # POST /poems.json
  def create
    if poem_params[:title].empty?
      redirect_to(request.referrer, notice: "제목이 비었습니다.") and return
    elsif  poem_params[:body].empty?
      redirect_to(request.referrer, notice: "본문이 비었습니다.") and return
    end

    @matchPoet = Poet.all.where("name = ? ", "#{params[:poem][:poet]}")
    if @matchPoet == nil
      redirect_to(request.referrer, notice: "시인이 존재하지 않습니다.") and return
    elsif @matchPoet.length > 1
      redirect_to(request.referrer, notice: "시인이 중복되어 존재합니다.") and return
    end
    
    @poem = Poem.new(poem_params)
    @poem.user_id = current_user.id
    @poem.poet = @matchPoet.first

    respond_to do |format|
      if @poem.save
        format.html { redirect_to @poem, notice: 'Poem was successfully created.' }
        format.json { render :show, status: :created, location: @poem }
      else
        format.html { render :new }
        format.json { render json: @poem.errors, status: :unprocessable_entity }
      end
    end    
  end

  # PATCH/PUT /poems/1
  # PATCH/PUT /poems/1.json
  def update
    @matchPoet = Poet.all.where("name = ? ", "#{params[:poem][:poet]}")
    if @matchPoet == nil
      redirect_to(request.referrer, notice: "시인이 존재하지 않습니다.") and return
    elsif @matchPoet.length > 1
      redirect_to(request.referrer, notice: "시인이 중복되어 존재합니다.") and return
    end
    @poem.poet = @matchPoet.first

    respond_to do |format|
      if @poem.update(poem_params)
        format.html { redirect_to @poem, notice: 'Poem was successfully updated.' }
        format.json { render :show, status: :ok, location: @poem }
      else
        format.html { render :edit }
        format.json { render json: @poem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poems/1
  # DELETE /poems/1.json
  def destroy
    @poem.likes.clear
    @poem.destroy
    respond_to do |format|
      format.html { redirect_to poems_url, notice: 'Poem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poem
      @poem = Poem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def poem_params
      params.require(:poem).permit(:title, :body, :year, :description, :picture)
    end
    
    def require_permission
      if current_user != @poem.user
        redirect_to root_path, notice: 'You don\'t have a permission for this post'
      end
    end

end
