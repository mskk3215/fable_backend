class Api::V1::PostsController < ApplicationController
  def index
    posts = Post.all.order(created_at: :desc)
    render json: posts
  end

  def create
    post = Post.new(post_params)
    if post.save
      render json:{post :post}
    else
      render json: { post.errors, status: 422}
    end
  end

  private
  def post_params
    params.require(:post).permit(:image)
  end
end
