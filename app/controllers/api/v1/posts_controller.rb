class Api::V1::PostsController < ApplicationController
  def index
    posts = Post.all.order(created_at: :desc)
    render json: posts
  end

  def create
    post = Post.new(posts_params)
    if post.save
      render json: { post: post}
    else
      render json: { status: 422 }
    end
  end

  private
  def posts_params
    params.permit(:image)    
    # params.require(:post).permit({image: [] } )
  end
end
