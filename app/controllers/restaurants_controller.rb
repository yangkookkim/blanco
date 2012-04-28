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
    search_results = Tabelog.search_restaurant(params[:query])
    render :json => search_results.to_json
  end

  def get_restaurant_review_html
    @restaurant = Restaurant.find(params[:id])
  end

  def show
  end
end
