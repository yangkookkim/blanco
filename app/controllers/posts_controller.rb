class PostsController < ApplicationController
  def create
    @post = Post.create(params[:post])
  end
end
