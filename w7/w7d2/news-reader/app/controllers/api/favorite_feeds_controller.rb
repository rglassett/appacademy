class Api::FavoriteFeedsController < ApplicationController

  def create
    @favorite_feed = current_user.favorite_feeds.build(fav_params)
    if @favorite_feed.save
      render :json => @favorite_feed
    else
      render :json => @favorite_feed.errors, status: :unprocessable_entity
    end
  end
  
  def destroy
    @favorite_feed = FavoriteFeed.find_by(
      user_id: current_user.id,
      feed_id: params[:id]
    )
    @favorite_feed.destroy!
    redirect_to user_url(current_user)
  end

  private
  def fav_params
    params.require(:favorite_feed).permit(:feed_id)
  end
end
