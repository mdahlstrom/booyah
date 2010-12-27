module Booyah
  class Source
    PROPERTIES = [:name, :url]
    PROPERTIES.each { |p| attr_accessor p }
  
    def initialize(hash = nil)
      PROPERTIES.each do |p|
        self.instance_variable_set "@#{p}", hash[p] unless hash[p].nil?
      end
    end
  end
end