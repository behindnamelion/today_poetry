class PoetsController < ApplicationController
  before_action :set_poet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :require_permission, only: [:edit, :update, :destroy]

  def search
    if params[:search].blank?
      redirect_to(poets_path, notice: "검색란이 비었습니다.") and return      
    else
      @parameter = params[:search].downcase
      @matchPoets = Poet.all.where("lower(name) LIKE ?", "%#{@parameter}%")      
      @matchPoems = Poem.all.where("lower(title) LIKE ?", "%#{@parameter}%")
    end
  end

  # GET /poets
  # GET /poets.json
  def index
    @poets = Poet.all
  end

  # GET /poets/1
  # GET /poets/1.json
  def show
  end

  # GET /poets/new
  def new
    @poet = Poet.new
  end

  # GET /poets/1/edit
  def edit
  end

  # POST /poets
  # POST /poets.json
  def create
    @poet = Poet.new(poet_params)
    @poet.user_id = current_user.id

    respond_to do |format|
      if @poet.save
        format.html { redirect_to @poet, notice: 'Poet was successfully created.' }
        format.json { render :show, status: :created, location: @poet }
      else
        format.html { render :new }
        format.json { render json: @poet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /poets/1
  # PATCH/PUT /poets/1.json
  def update
    respond_to do |format|
      if @poet.update(poet_params)
        format.html { redirect_to @poet, notice: 'Poet was successfully updated.' }
        format.json { render :show, status: :ok, location: @poet }
      else
        format.html { render :edit }
        format.json { render json: @poet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /poets/1
  # DELETE /poets/1.json
  def destroy
    @poet.destroy
    respond_to do |format|
      format.html { redirect_to poets_url, notice: 'Poet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poet
      @poet = Poet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def poet_params
      params.require(:poet).permit(:name, :birthplace, :birthyear, :description, :portrait)
    end

    def require_permission
      if current_user != @poet.user
        redirect_to root_path, notice: 'You don\'t have a permission for this post'
      end
    end
end
