class Api::V1::PostsController < ApplicationController
  skip_before_action :authenticate_user!, only:[:index]

  def index
    posts = Post.all.order(created_at: :desc)
    render json: posts
  end

  def create
    post_params[:image].each do |image|
      post = Post.new(image: image, user: current_user)
      if post.save
      else
        render json: post.errors
      end
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  private
  def post_params
    params.require(:post).permit( {image: []})
  end
end
