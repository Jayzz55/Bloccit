class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    
    if favorite.save
      flash[:notice] = "Favorited post"
      redirect_to [@post.topic, @post]
    else
      flash[:error] = "Unable to add favorite. Please try again."
      redirect_to @post
    end
  end

  def destroy
  @post = Post.find(params[:post_id])
  favorite = current_user.favorites.find(params[:id])
 
  authorize favorite

  if favorite.destroy
    flash[:notice] = "Un-Favorited post"
      redirect_to [@post.topic, @post]
  else
    flash[:error] = "Unable to add favorite. Please try again."
    redirect_to @post
  end
 end

end
