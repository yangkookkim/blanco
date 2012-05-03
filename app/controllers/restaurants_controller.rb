# coding: utf-8
require 'tabelog'

class RestaurantsController < ApplicationController
  layout 'restaurant', :except => [:get_restaurant_review_html]

  def create
    res_id = params[:restaurant_id]
    emp_id = params[:employee_id]
    message = params[:message]
    emp = Employee.find(emp_id)
    res = Group.find(res_id)
    if (@post = Post.create(:message => message))
      emp.posts << @post
      res.posts << @post
    end
    render :layout => false
  end

  def index
    @restaurants = Restaurant.find(:all)
  end

  def sort
    sort_method = params[:sort_method]
    sort_items = params[:sort_items]
    puts sort_method.class
    case sort_method
    when "date_updated"
        @restaurants_sorted = sort_by_date_updated(sort_items)
    when "num_posts"
        @restaurants_sorted = sort_by_num_posts(sort_items)
    else
	raise "Unknown sort method"
    end
        html = render_to_string :partial => "/restaurants/each_restaurant", :collection => @restaurants_sorted
        render :json => {:success => 1, :html => html}
  end

  def index_js
    @employee = Employee.find(params[:employee_id])
  end

  def index_get_active_message
    message = Post.find(params[:post_id]).message
    render :json => message.to_json
  end

  def index_get_restaurant_record
    restaurant = Restaurant.find(params[:restaurant_id])
    render :json => restaurant.to_json
  end

  def index_get_commented_restaurants_all
    all_restaurants = Restaurant.find(:all)
    restaurants = []
    restaurants = all_restaurants.each {|r| restaurants << r unless r.posts.empty?}
    render :json => restaurants.to_json
  end

  def search_restaurant
    @search_results = Tabelog.search_restaurant(params[:query])
    html = render_to_string :partial => "/restaurants/each_restaurant", :collection => @search_results
    render :json => {:success => 1, :html => html}
  end

  def get_restaurant_review_html
    @restaurant = Restaurant.find(params[:id])
  end

  def show
  end

  private

  def sort_by_date_updated(items)
    restaurants_sorted = Restaurant.find(items, :include => :posts, :order => "posts.updated_at DESC")
  end

  def sort_by_num_posts(items)
    restaurants = []
    items.each do |item|
        restaurants << Restaurant.find(item)
    end
    restaurants_sorted = restaurants.sort {|a,b| b.posts.size <=> a.posts.size}
  end
end
