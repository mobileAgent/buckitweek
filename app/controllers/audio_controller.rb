class AudioController < ApplicationController

  caches_page :index

  def index
    @files = Dir.glob("#{RAILS_ROOT}/public/audio/*.{pdf,jpg,mp3}")
    @files.sort!
  end
  
end
