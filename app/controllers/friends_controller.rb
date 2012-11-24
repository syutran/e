class FriendsController < ApplicationController
  def index
    @managers = Friend.find(:all, :conditions => ["friend_id = ? ",current_user.id])
    @friends = current_user.friends.all
  end
  def add_friend
    user = User.find(params[:id])
    unless current_user.friends.find_by_friend_id(user.id)
      current_user.friends.create(:user_id => current_user.id, :friend_id => user.id)
    end
  end
end
