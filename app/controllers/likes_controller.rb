class LikesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    like = Like.find_by(poem_id: params[:poem_id], user_id: current_user.id)
    
    if like.present?
      like.destroy
    else
      Like.create(poem_id: params[:poem_id], user_id: current_user.id)
    end
    
    redirect_back(fallback_location: root_path)
  end
end
