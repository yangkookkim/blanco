class PostsGroupsController < PostsController
  def create
    tmpimg_id = params[:tempimage_id]
    tmpimg = Tempimage.find(tmpimg_id) if tmpimg_id
    @post = create_post(params)
    @post.image = tmpimg.image if tmpimg
    @post.save

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
end
