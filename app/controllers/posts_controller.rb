class PostsController < ApplicationController
  def create
  #return redirect_to '/404.html' unless request.xhr?
  @post = Post.new(params[:post])
  if @post.save
    html = render_to_string :partial => "/post/each_post", :collection => [@post]
    render :json => {:success => 1, :html => html, :lastpost_id => @post.id}
  else
    render :json => {:error => @post.errors}
  end
  end
end
