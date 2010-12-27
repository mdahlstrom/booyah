module Booyah
  class User
    PROPERTIES = [:uid, :sources, :followers, :followings, :nick, :clip_count]
    PROPERTIES.each { |p| attr_accessor p }
  
    def initialize(hash = nil)
      PROPERTIES.each do |p|
        self.instance_variable_set "@#{p}", hash[p] unless hash[p].nil?
      end
    end
    
  end
end