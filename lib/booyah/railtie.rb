require 'rails'
require 'audio_boo'
require 'booyah/audio_clip'
require 'booyah/source'
require 'booyah/tag'
require 'booyah/user'
module Rails
  module Booyah
    class Railtie < Rails::Railtie
    end
  end
end