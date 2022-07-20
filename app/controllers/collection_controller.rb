# frozen_string_literal: true

class CollectionView::CollectionController < ::ApplicationController

  def index

    topic = Topic.where(id: params[:id])
    posts = Post.where(topic_id: params[:id])
    
    user = nil
    avatar = nil

    if ! topic.nil? & ! topic[0].nil?
      topic = topic[0]

      user = User.find_by(id: topic[:user_id])
      if ! user.nil?
        avatar_template = user.avatar_template.dup
        avatar = avatar_template.gsub!("{size}", "120") 
      end
    end

    collection_posts = posts.map { |post|
      collection_post={}

      collection_post[:date] = post[:created_at]
      collection_post[:id] = post[:id]

      html = Nokogiri::HTML.fragment(post[:cooked])
      collection_post[:imgs] = html.css('img').map { |l| p l.attr('src') }

      html = Nokogiri::HTML.fragment(post[:cooked])
      html.search('img').remove
      collection_post[:cooked] = html
      
      collection_post
    }

    render json: {avatar: avatar, user: user, topic: topic, posts: posts, collection_posts: collection_posts }
  end
end
