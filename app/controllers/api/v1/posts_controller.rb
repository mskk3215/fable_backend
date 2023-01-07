class Api::V1::PostsController < ApplicationController
  def index
    posts = Post.all.order(created_at: :desc)
    render json: posts
  end

  def create
    post = Post.new(posts_params)
    if post.save
    else
      binding.pry
      render json: post.errors
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  private
  def posts_params
    params.require(:post).permit(image:[])

  end
end
