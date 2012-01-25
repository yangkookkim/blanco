class PostsController < ApplicationController
  def create
    # This is called from uploading image
    if params[:type] == "image"
      e = Employee.find(params[:employee_id])
      g = Group.find(params[:group_id])
      @post = Post.new(params[:post])
      e.posts << @post
      g.posts << @post
      
      if @post.save
        render :text => @post.id
        return
      end
    end

    @post = Post.new(params[:post])
    if @post.save
      html = render_to_string :partial => "/posts/each_post", :collection => [@post]
      render :json => {:success => 1, :html => html, :lastpost_id => @post.id}
    else
      render :json => {:error => @post.errors}
    end
  end
  
  def update
    msg = params[:post][:message]
    id = params[:id]
    @post = Post.find(id)
    if @post.update_attribute(:message, msg)
      html = render_to_string :partial => "/posts/each_post", :collection => [@post]
      render :json => {:success => 1, :html => html, :lastpost_id => @post.id}
    end
  end
end
