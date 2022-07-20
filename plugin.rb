# frozen_string_literal: true

# name: discord-collection-view
# about: Convert collection threads to dedicated pages
# version: 1.0.0
# authors: ScottMastro
# url: https://github.com/ScottMastro/discourse-collection-view
# required_version: 2.7.0
# transpile_js: true

enabled_site_setting :collection_view_enabled

register_asset 'stylesheets/common/common.scss'
register_asset 'stylesheets/mobile/mobile.scss', :mobile

after_initialize do

  module ::CollectionView
    PLUGIN_NAME = "discord-collection-view"
  end
  
  class CollectionView::Engine < Rails::Engine
      engine_name CollectionView::PLUGIN_NAME
      isolate_namespace CollectionView
  end

  require_relative 'app/controllers/collection_controller.rb'
  
  CollectionView::Engine.routes.draw do
    #get "/collection" => "collection#index"
    get "/collection/:id" => "collection#index"

  end
  
  Discourse::Application.routes.append do
    mount CollectionView::Engine, at: "/"
  end
  

end
