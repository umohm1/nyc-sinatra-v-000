require 'pry'

class FiguresController < ApplicationController
    
    get '/figures' do
      @figures = Figure.all
      erb :'figures/index'
    end
    
    get '/figures/new' do
      erb :'figures/new'
    end 
    
    
    post '/figures' do
      @figure = Figure.create(params[:figure])
      erb :'figures/new'
    end

    
    
end 