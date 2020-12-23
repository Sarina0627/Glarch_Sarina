require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'sinatra/json'
require './models/contribution.rb'
require "date"

require 'open-uri'
require 'net/http'
require 'json'

enable :sessions

before do
  Dotenv.load
  Cloudinary.config do |config|
    config.cloud_name = ENV["CLOUD_NAME"]
    config.api_key = ENV["CLOUDINARY_API_KEY"]
    config.api_secret = ENV["CLOUDINARY_API_SECRET"]
  end
  Geocoder.config do |config|
    config.api_key = ENV["GEOCODING_API_KEY"]
  end
end

get '/' do
  erb :sign_up
end

get '/index' do
    numbers = Array.new(5).map{rand(1..Contribution.count)}
    contributions = Contribution.find(numbers)
    @markers = Array.new

    contributions.each do | contribution |
      user = contribution.user
      typecategory = contribution.typecategory
      areacategory = contribution.areacategory
      marker = Hash.new()
      marker['coordinates'] = Geocoder.coordinates(contribution.area)
      marker['user_id'] = user.try(:id)
      marker['user_name'] = user.try(:username)
      marker['created_at'] = contribution.created_at.strftime("%Y-%m-%d")
      marker['body'] = contribution.body
      marker['typecategory_id'] = typecategory.try(:id)
      marker['typecategory_name'] = typecategory.try(:type_name)
      marker['areacategory_id'] = areacategory.try(:id)
      marker['areacategory_name'] = areacategory.try(:area_name)
      @markers.push(marker.to_json)
   end
  @type_categories = Typecategory.all
  @area_categories = Areacategory.all
  erb :index
end

get '/timeline' do
  @contributions = Contribution.where(public:"t").all.order("id desc")
  @type_categories = Typecategory.all
  @area_categories = Areacategory.all
  erb :timeline
end


get '/create_post' do
  @type_categories = Typecategory.all
  @area_categories = Areacategory.all
  erb :create_post
end

post '/create_post' do
  img_url = ""
  if params[:file]
    img = params[:file]
    tempfile = img[:tempfile]
    upload = Cloudinary::Uploader.upload(tempfile.path)
    img_url = upload["url"]
  end

  Contribution.create({
    body: params[:body],
    user_id: session[:user],
    img: img_url,
    typecategory_id: params[:type_category],
    areacategory_id: params[:area_category],
    public: params[:public],
    area: User.find(session[:user]).area
  })
  redirect '/timeline'
end


get '/edit/:id' do
  @renew = Contribution.find(params[:id])
  erb :edit
end

post '/edit/:id' do
@renew = Contribution.find(params[:id])
@renew.update({
  body: params[:body]
})
redirect '/'
end

get '/signin' do
  erb :sign_in
end

get '/signup' do
  erb :sign_up
end

post '/signup' do

  @user=User.create({
    username: params[:username],
    password: params[:password],
    password_confirmation: params[:password_confirmation],
    area: params[:area],
    introduction: params[:introduction],
    latitude: Geocoder.coordinates("#{params[:area]}")[0],
    longitude: Geocoder.coordinates("#{params[:area]}")[1],
    color: params[:color]
  })

  if @user.persisted?
    session[:user] = @user.id
  end
  redirect '/index'
end

post '/signin' do
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

get '/mypage' do
  @mycontributions=Contribution.where(user_id: session[:user]).all.order("id desc")
  erb :mypage
end

get '/:id/userspage' do
  @userscontributions=Contribution.where(user_id: params[:id]).where(public:"t").all.order("id desc")
  @name=User.find(params[:id]).username
  @area=User.find(params[:id]).area
  @introduction=User.find(params[:id]).introduction
  erb :userspage
end

post '/comment/:id' do
  content = Contribution.find(params[:id])
  content.reactions.create([
    {comment:params[:comment],
     user_id:session[:user]
    }
  ])

  # content.reactions.create([
    # {favorite:params[:id]}
  # ])
  redirect '/timeline'
end

post '/favorite/:id' do
  content = Contribution.find(params[:id])
  content.newfavorites.create([
    {favorite:params[:id],
      user_id:session[:user]
    }
  ])
  redirect "/timeline"
end

post '/unfavorite/:id' do
  Newfavorite.find_by(user_id:session[:user]).destroy
  redirect "/favorite_page"
end

get '/favorite_page' do
  @myfavorite = Newfavorite.where(user_id:session[:user]).all.order("id desc")
  erb :favoritepage
end

post '/fav_comment/:id' do
  content = Contribution.find(params[:id])
  content.favreactions.create([
    {favmemo:params[:memo]
    }
  ])
  redirect "/favorite_page"
end

get '/typecategory/:id' do
  @contributions = Contribution.where(typecategory_id: params[:id]).all.order("id desc")
  @type_categories = Typecategory.all
  @area_categories = Areacategory.none
  @type_category = Typecategory.find(params[:id])
  @type_category_name= @type_category.type_name
  erb :type_category
end

get '/areacategory/:id' do
  @contributions = Contribution.where(areacategory_id: params[:id]).all.order("id desc")
  @area_categories = Areacategory.all
  @type_categories = Typecategory.none
  @area_category = Areacategory.find(params[:id])
  @area_category_name= @area_category.area_name
  erb :area_category
end

get '/serch' do
  @contributions = Contribution.where("body LIKE ?", "%#{ params[:serch_word]}%").all.order("id desc")
  erb :timeline
end