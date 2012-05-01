# coding: utf-8

require 'net/http'
require 'uri'
require 'nokogiri'
require 'pp'
require 'active_record'
require 'json'
require './app/models/restaurant'
require 'open-uri'

ActiveRecord::Base.establish_connection(
   :adapter => 'sqlite3',
   :host => 'localhost',
   :database => './db/development.sqlite3'
 )

class Tabelog
  @@api_key="3c4650267b573c677fc114e9283396a28f957323"
  @@restaurant_search_uri="http://api.tabelog.com/Ver2.1/RestaurantSearch/"
  @@reviewimage_search_uri="http://api.tabelog.com/Ver1/ReviewImageSearch/"
  @@base_latitude=35.645335.to_s
  @@base_longitude=139.748545.to_s
  

  def self.get_restraunt(page)
    pagenum = page.to_s
    @search_range="medium"
    @result_set="large"
    
    uri= URI.parse(@@restaurant_search_uri+ "?" + "Latitude=" + @@base_latitude + "&Longitude=" + @@base_longitude \
         + "&SearchRange=" + @search_range + "&ResultSet=" + @result_set + "&Key=" + @@api_key + "&PageNum=" \
         + pagenum)
    result = Net::HTTP.get(uri)
  end

  def self.get_review_image(rcd)
    uri= URI.parse(@@reviewimage_search_uri+ "?" + "Rcd=" + rcd + "&Key=" + @@api_key)
    result = Net::HTTP.get(uri)
    result_xml = Nokogiri::XML(result)
    result_xml.xpath("//Item").each do |item|
      # Tabelog reviewimage API returns top most popular image.
      # If Item has 外観 image, return the url.
      if item.xpath("ImageStatus").text == "外観"
        image_url = item.xpath("ImageUrlL").text
        return image_url
      end
    end
    # If Item doesn't have 外観 image, then return the url of first Item.
    if result_xml.xpath("//Item")[0]
      image_url = result_xml.xpath("//Item")[0].xpath("ImageUrlL").text
    else
      nil
    end
  end
  
  def self.search_restaurant(keyword)
    # First search local database
    results = []
    results = search_local_database(keyword)
    if results.empty?
      results = search_tabelog_database(keyword)
      unless results.empty?
        results.each do |restaurant|
          result = store_into_local_database(restaurant)
          raise "Failed to store tabelog restaurant into local database" if result.nil?
        end
        results = search_local_database(keyword)
      end
    end
    results
  end

  def self.search_tabelog_database(keyword)
    keyword_reg = Regexp.new(keyword)
    pagerange = (1..50)
    xmls = []
    items = []
    match_items = []
    pagerange.each do |i|
      res = Tabelog.get_restraunt(i)
      xmls << Nokogiri::XML(res)
    end
    xmls.each do |xml|
      xml.xpath("//Item").each do |item|
        items << item
      end        
    end

    items.each do |i|
      if i.xpath("RestaurantName").text =~ keyword_reg
        rcd = i.xpath("Rcd").text
        name = i.xpath("RestaurantName").text
        latitude = i.xpath("Latitude").text
        longitude = i.xpath("Longitude").text
        image_url = Tabelog.get_review_image(rcd)
        h = {"rcd" => rcd, "name" => name, "latitude" => latitude, "longitude" => longitude, "image" => image_url}
        match_items << h
      end
    end
    match_items
  end

  def self.search_local_database(keyword)
    results = nil
    results = Restaurant.find(:all, :conditions => ["name like ?", "%#{keyword}%"])
  end

  def self.store_into_local_database(restaurant)
    rcd = restaurant["rcd"]
    name = restaurant["name"]
    latitude = restaurant["latitude"].to_f
    longitude = restaurant["longitude"].to_f
    imagefile = save_image_file(restaurant["image"]) # Save image file on the web to local
    image = File.open(imagefile)
    result = Restaurant.create(:rcd => rcd, :name => name, :latitude => latitude, :longitude => longitude, :image => image)
  end

  def self.save_image_file(url)
    tmpdir = "#{Rails.root}/tmp"
    filename = File.basename(url)
    filepath = "#{tmpdir}/#{filename}"
    open(filepath, 'wb') do |file|
      open(url) do |data|
        return filepath if file.write(data.read)
      end
    end
    nil
  end
end
#search_results = Tabelog.search_by_keyword("パスタ")
#search_results.each do |res|
#  puts res["name"]
#  puts "#{res['latitude']},#{res['longitude']}"
#end
##Tabelog.get_review_image(111)
