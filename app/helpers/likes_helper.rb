module LikesHelper
    def poem_liked_by_user?(poem, user)
        if user == nil
            return false
        else
            like = Like.find_by(poem_id: poem.id, user_id: user.id )
            return like.present? ? true : false
        end
    end
end
