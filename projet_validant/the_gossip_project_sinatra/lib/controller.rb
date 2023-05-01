require 'bundler'
require 'gossip'
require 'comment'

Bundler.require

class ApplicationController < Sinatra::Base # Définit une nouvelle classe ApplicationController héritant de Sinatra::Base
  get '/' do # Définit une route pour la requête GET sur '/'
    @gossips = Gossip.all # Récupère tous les gossips
    erb :index # Affiche la vue index.erb
  end

  get '/gossips/new/' do # Définit une route pour la requête GET sur '/gossips/new/'
    erb :new_gossip # Affiche la vue new_gossip.erb
  end

  post '/gossips/new/' do # Définit une route pour la requête POST sur '/gossips/new/'
    Gossip.new(params['gossip_author'], params['gossip_content']).save # Crée et enregistre un nouveau gossip avec les paramètres reçus
    redirect '/' # Redirige vers la page d'accueil
  end

  get '/gossips' do  # Définit une route pour la requête GET sur '/gossips'
    @all_gossips = Gossip.all # Récupère tous les gossips
    erb :gossips_index # Affiche la vue gossips_index.erb
  end


  get '/gossips/:id' do # Définit une route pour la requête GET sur '/gossips/:id', où :id est un paramètre dynamique
    @gossip_id = params['id'].to_i # Convertit le paramètre 'id' en entier et l'affecte à la variable d'instance @gossip_id
    @gossip = Gossip.find(@gossip_id) # Trouve et récupère le gossip correspondant à l'ID
    @comments = Comment.find_by_gossip_id(@gossip_id) # Trouve et récupère les commentaires associés au gossip
    erb :gossip_show  # Affiche la vue gossip_show.erb
  end

  get '/gossips/:id/edit' do # Définit une route pour la requête GET sur '/gossips/:id/edit', où :id est un paramètre dynamique
    @gossip = Gossip.find(params['id'].to_i) # Trouve et récupère le gossip correspondant à l'ID
    erb :edit # Affiche la vue edit.erb
  end

  post '/gossips/:id/update' do # Définit une route pour la requête POST sur '/gossips/:id/update', où :id est un paramètre dynamique
    gossip = Gossip.find(params['id'].to_i) # Trouve et récupère le gossip correspondant à l'ID
    gossip.update(params['gossip_author'], params['gossip_content']) # Met à jour le gossip avec les nouveaux paramètres reçus
    redirect "/gossips/#{gossip.id}" # Redirige vers la page du gossip mis à jour
  end

  post '/gossips/:id/comment' do
    gossip_id = params['id'].to_i
    comment_content = params['comment_content']
    Comment.new(nil, gossip_id, comment_content).save
    redirect "/gossips/#{gossip_id}"
  end
end
