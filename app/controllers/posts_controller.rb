class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  
  def index # posts_path , /posts, GET
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show # post_path, /post/:id, GET
    #using set_post before_action
    @comment = Comment.new
  end

  def new # new_post_path, /posts/new, GET
    @post = Post.new
  end

  def create # posts_path, /posts, POST
    @post = Post.new(post_params) #strong parameter
    @post.user = current_user

    if @post.save
      flash[:notice] = 'Post has been saved'
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end # edit_post_path, /post/:id/edit, GET
    #using set_post before_action

  def update # post_path, /post/:id, PUT or PATCH
    #using set_post before_action

    if @post.update(post_params)#strong paramters
      flash[:notice] = 'Post has been updated'
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote #using set_post before_action
    Vote.create(voteable: @post, user: current_user, vote: params[:vote])
    flash[:notice] = 'Your vote has been submitted'
    redirect_to :back
  end

private

  def post_params #strong param private
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post #before action method
    @post = Post.find(params[:id])
  end

end
