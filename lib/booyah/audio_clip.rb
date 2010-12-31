module Booyah
  class AudioClip
    PROPERTIES = [:id, :duration, :title, :location,
                  :recorded_at, :uploaded_at, :play_count,
                  :comment_count, :tags, :sources, :user]
    PROPERTIES.each { |p| attr_accessor p }
    
    def initialize(hash = nil)
      PROPERTIES.each do |p|
        self.instance_variable_set "@#{p}", hash[p] unless hash[p].nil?
      end
    end
    
  end
end