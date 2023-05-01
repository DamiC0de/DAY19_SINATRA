require 'bundler'
require 'gossip'

Bundler.require

class ApplicationController < Sinatra::Base
  get '/' do
    @gossips = Gossip.all
    erb :index
  end

  get '/gossips/new/' do
    erb :new_gossip
  end

  post '/gossips/new/' do
    Gossip.new(params['gossip_author'], params['gossip_content']).save
    redirect '/'
  end

  get '/gossips' do
    @all_gossips = Gossip.all
    erb :gossips_index
  end


  get '/gossips/:id' do
    @gossip_id = params['id'].to_i
    @gossip = Gossip.find(@gossip_id)
    erb :gossip_show
  end

  get '/gossips/:id/edit' do
    @gossip = Gossip.find(params['id'].to_i)
    erb :edit
  end

  post '/gossips/:id/update' do
    gossip = Gossip.find(params['id'].to_i)
    gossip.update(params['gossip_author'], params['gossip_content'])
    redirect "/gossips/#{gossip.id}"
  end
end
