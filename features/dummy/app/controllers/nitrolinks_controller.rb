class NitrolinksController < ApplicationController
  def index
    @track_get = session.delete(:track_get)
    @uuid = SecureRandom.uuid
  end

  def link1
  end

  def redirecting
    redirect_to action: 'redirected'
  end

  def redirected
  end

  def changing
    session[:track_get] = params[:track]
    redirect_to action: 'index'
  end

  def changing_post
    session[:track_get] = params[:track]
    redirect_to action: 'index'
  end

  def blank
  end

  def error_500
    raise "Sample error"
  end
end

