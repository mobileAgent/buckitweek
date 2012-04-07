class AudioController < ApplicationController

  caches_page :index

  def index
    @files = Dir.glob("#{Rails.root}/public/audio/*.{pdf,jpg,mp3}")
    @files.sort!
  end
  
end
