# coding: utf-8
require 'tabelog'

class RestaurantsController < ApplicationController
  layout 'restaurant', :except => [:get_restaurant_review_html]
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
