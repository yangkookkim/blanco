require 'em-websocket'

class PostsController < ApplicationController
  def create
  end

  def show
    id = params[:id]
    @post = Post.find(id)
    render :layout => false
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    render :json => {:res => 1}
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

  private
  def create_post(params)
    topic_name = params[:topic]
    topic_id = params[:topic_id]
    employee_id = params[:employee_id]
    message = params[:message]
    topic_sym = "#{topic_name.downcase}_id".to_sym
    Post.new(topic_sym => topic_id, :employee_id => employee_id, :message => message)
  end
end
