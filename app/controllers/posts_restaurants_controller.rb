class PostsRestaurantsController < PostsController
  def create
    rating = params[:rating].empty? ? 0 : params[:rating]
    restaurant = Restaurant.find(params[:topic_id])
    @post = create_post(params)
    @post.rating = rating
    @post.save
    restaurant.calculate_rating(@post.rating)
    restaurant.save

    render :layout => false
  end
end
