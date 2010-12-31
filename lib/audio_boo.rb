require 'httparty'
class AudioBoo
  include HTTParty
  base_uri "api.audioboo.fm"
  

  #example AudioBoo.by_location({ "find[latitude]" => 51.633, "find[longitude]" => -0.064})
  #example AudioBoo.by_location(51.633,-0.064)
  #http://api.audioboo.fm/audio_clips/located.json?latitude=51.633&longitude=-0.064
  def self.by_location(lat,lng)
    res = self.get("/audio_clips/located.json?find[latitude]=#{lat}&find[longitude]=#{lng}")
    array = res["body"]["audio_clips"]
    generate_clips_array(array)
  end
  
  def self.nearby(clip)
    res = self.get("/audio_clips/#{clip.id}/nearby.json")
    array = res["body"]["audio_clips"]
    generate_clips_array(array)
  end
  
  private
  
  def self.generate_clips_array(clips_data)
    clips = Array.new
    clips_data.each do |clip_data|
      clips << generate_clip(clip_data)
    end
    return clips
  end
  
  def self.generate_clip(clip_data)
    #split the hash
    urls = clip_data["urls"]
    tags = clip_data["tags"]
    user = clip_data["user"]
    location = clip_data["location"]
    counts = clip_data["counts"]
    #delete them from the clip data, since we are generating objects for them later
    clip_data.delete("urls")
    clip_data.delete("tags")
    clip_data.delete("user")
    clip_data.delete("counts")
    clip_data.delete("location")
    #create clips and the subklasses for sources,tags,user
    clip_data = clip_data.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    clip = Booyah::AudioClip.new(clip_data)
    clip.sources = generate_sources(urls)
    clip.tags = generate_tags(tags)
    clip.user = generate_user(user)
    clip.play_count = counts["plays"]
    clip.comment_count = counts["comments"]
    return clip
  end
  
  def self.generate_sources(data)
    if data.nil?
      return nil
    end
    result = Array.new
    data.each_pair do |k,v|
      result << Booyah::Source.new({:name => k, :url => v})
    end
    return result
  end
  
  def self.generate_tags(data)
    if data.nil?
      return nil
    end
    result = Array.new
    data.each do |t|
      result << Booyah::Tag.new({ :display => t["display_tag"], :normalised => t["normalised_tag"], :url => t["url"]})
    end
    return result
  end
  
  def self.generate_user(data)
    if data.nil?
      return nil
    end
    urls = data["urls"]
    counts = data["counts"]
    data.delete("urls")
    data.delete("counts")
    user = Booyah::User.new({:uid => data["id"], :nick => data["username"], :sources => generate_sources(urls)})
    unless counts.nil?
      user.followers = counts["followers"]
      user.followings = counts["followings"]
      user.clip_count = counts["audio_clips"]
    end
    return user
  end
  
end