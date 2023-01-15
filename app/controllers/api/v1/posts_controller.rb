class Api::V1::PostsController < ApplicationController
  before_action :current_user

  def index
    posts = Post.all.order(created_at: :desc)
    render json: posts
  end

  def create
    
    post_params[:image].each do |image|
      post = Post.new(image: image)
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
    binding.pry
    # params.require(:post).permit( {image: []})
    params.require(:post).permit( {image: []}).merge(user_id: current_user.id)

  end
end
