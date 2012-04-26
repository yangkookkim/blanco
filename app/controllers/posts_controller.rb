require 'em-websocket'

class PostsController < ApplicationController
  def create
    topic = params[:topic]
    topic_id = params[:topic_id]
    emp_id = params[:employee_id]
    message = params[:message]
    emp = Employee.find(emp_id)
    topic = Object.class.const_get(topic).find(topic_id)
    if (@post = Post.create(:message => message))
      emp.posts << @post
      topic.posts << @post
    end
    render :layout => false
    ## This is called from uploading image
    #if params[:type] == "image"
    #  e = Employee.find(params[:employeemp_id])
    #  g = Group.find(params[:group_id])
    #  @post = Post.new(params[:post])
    #  e.posts << @post
    #  g.posts << @post
    #  
    #  if @post.save
    #    # Caution!! "render :json => @post" does not work with jQuery.upload plugin.
    #    # If you do, jQuery upload cannot parse the response as json.
    #    # Only render:text => object.to_json works.
    #    render :text => @post.to_json
    #    return
    #  end
    #end

    #@post = Post.new(params[:post])
    #if @post.save
    #  html = render_to_string :partial => "/posts/each_post", :collection => [@post]
    #  render :json => {:success => 1, :html => html, :lastpost_id => @post.id}
    #else
    #  render :json => {:error => @post.errors}
    #end
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
end
