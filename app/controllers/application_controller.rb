class ApplicationController < ActionController::Base
  include AuthHelper
  before_filter :signed_in, :except => [:google_callback]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  
  def signed_in
    if not myEmail
      session[:auth_redirect] = request.path
      redirect_to '/auth/google_oauth2'
    else
      log_click
    end
  end

  def log_click
    Click.create(
      email: myEmail,
      path: request.path,
      params: request.params)
  end

  def board
    # validation stuff
    @errors = flash[:errors].to_json
    @params = flash[:object_params].to_json
    @error_type = flash[:error_type]
    @searching = false

    @events = Event.list(myEmail)
    @brags = Brag.list(myEmail)
    @posts = Post.list(myEmail)
    @maps_api_key = ENV['MAPS_API_KEY']
    render 'layouts/board', layout: false
  end

  def members
    @members = Member.all
    render 'layouts/members'
  end

  def create_member
    Member.create(
      name: params[:name], 
      email:params[:email],
      position: params[:position])
    redirect_to '/members'
  end

  def delete_member
    Member.find(params[:id]).destroy
    redirect_to '/members'
  end

end
