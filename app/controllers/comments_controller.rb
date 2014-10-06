class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = @post
    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post, @comment]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
