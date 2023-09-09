class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post = Post.find(params[:post_id])

    if @comment.save

      redirect_to user_post_path(user_id: params[:user_id], id: params[:post_id])
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @user = @comment.author
    @post = @comment.post

    if @comment.destroy
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully destroyed.'
    else
      redirect_to user_post_path(@user, @post), notice: 'Comment was not destroyed.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end