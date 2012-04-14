# coding: utf-8
require 'tabelog'

class LunchmapsController < ApplicationController
  layout 'lunchmap', :except => [:get_restaurant_review_html]
  def index
  end

  def index_js
    @employee = Employee.find(params[:employee_id])
  end

  def search_restaurant
    search_results = Tabelog.search_restaurant(params[:query])
    render :json => search_results.to_json
  end

  def get_restaurant_review_html
    @restaurant = Restaurant.find(params[:id])
  end
end
