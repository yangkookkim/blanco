class PostsGroupsController < PostsController
  def create
    topic_name = params[:topic]
    topic_id = params[:topic_id]
    emp_id = params[:employee_id]
    tmpimg_id = params[:tempimage_id]
    message = params[:message]
    emp = Employee.find(emp_id)
    tmpimg = Tempimage.find(tmpimg_id) if tmpimg_id
    topic = Object.class.const_get(topic_name).find(topic_id)

    if tmpimg
      @post = Post.create(:message => message, :image => tmpimg.image)
    else
      @post = Post.create(:message => message)
    end

    if @post
      emp.posts << @post
      topic.posts << @post
    else
      raise "Failed to create post"
    end
    render :layout => false
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
