require 'gossip' # a besoin du fichier gossip

class ApplicationController < Sinatra::Base # heritage des fonctionnalités de base de Sinatra
  get '/' do # GET = envoi des données et envoi user a l'URL '/'
		 erb :index, locals: {gossips: Gossip.all}
		 # lie la view de index à l'URL
		 # renvoie via locals les données Gossip.all à la view
  end

  get '/gossips/new/' do # envoi user à l'URL
  	erb :new_gossip # lie la view de new_gossip à l'URL
  end

  post '/gossips/new/' do # POST = recoit des données, permet des input a user
		Gossip.new(params["gossip_author"], params["gossip_content"]).save
		# crée un nouveau gossip avec un nom et un texte et l'enregistre dans la DB
  	redirect '/' # une fois le gossip posté, renvoi user à la page d'accueil
  end

	get '/gossips/:id/' do
		erb :show, locals: {id: params["id"], gossip: Gossip.find(params["id"].to_i)}
		# indique quels params pour executer le code
	end

	get '/gossips/:id/edit/' do
		erb :edit, locals: {id: params["id"]}
	end

	post '/gossips/:id/edit/' do
		Gossip.new(params["gossip_author"], params["gossip_content"]).update
		redirect '/'
	end
end