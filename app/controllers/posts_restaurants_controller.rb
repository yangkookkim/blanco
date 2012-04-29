class PostsRestaurantsController < PostsController
  def create
    topic_name = params[:topic]
    topic_id = params[:topic_id]
    emp_id = params[:employee_id]
    message = params[:message]
    rating = params[:rating]
    emp = Employee.find(emp_id)
    topic = Object.class.const_get(topic_name).find(topic_id)
    if (@post = Post.create(:message => message, :rating => rating))
      puts "DEBUG #{rating}"
      emp.posts << @post
      topic.calculate_rating(@post.rating)
      topic.posts << @post
      topic.save
    end
    render :layout => false, :template => "posts_#{topic_name.downcase.pluralize}/create"
  end
end
