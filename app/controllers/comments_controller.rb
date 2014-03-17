class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    # @comment.post = @post #is condensed to line 5
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user = current_user
    if @comment.save
      flash[:notice] = 'Comment has been saved'
      redirect_to post_path(@post)
    else
      render 'posts/show'
   end
 end
end