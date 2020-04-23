class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @like = Like.find_by(poem_id: params[:poem_id], user_id: current_user.id)
    
    if @like.present?
      @like.destroy
      @like = nil
    else
      @like = Like.create(poem_id: params[:poem_id], user_id: current_user.id)
    end
    
    @poem = Poem.find(params[:poem_id])
    @like_count = @poem.likes.count
  end
end
