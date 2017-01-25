require 'pry'

class FiguresController < ApplicationController

    get '/figures' do
      @figures = Figure.all
      erb :'figures/index'
    end

    get '/figures/new' do
      erb :'figures/new'
    end

    get '/figures/:id' do
      @figure = Figure.find_by_id(params[:id])
      erb :'/figures/show'
    end


    post '/figures' do
      @figure = Figure.create(params[:figure])
       if !params[:landmark][:name].empty?
        @figure.landmarks << Landmark.create(params[:landmark])
      end

      if !params[:title][:name].empty?
        @figure.titles << Title.create(params[:title])
      end

      @figure.save
      redirect to "/figures/#{@figure.id}"
    end

     get '/figures/:id/edit' do
      @figure = Figure.find_by_id(params[:id])
      erb :'figures/edit'
    end

     patch '/figures/:id' do
      #  binding.pry
      @figure = Figure.find_by_id(params[:id])
      # @figure.name = params[:figure][:name]
      # binding.pry
      @figure.update(params[:figure])

      @figure.titles << Title.find_or_create_by(name: params[:title][:name])
      @figure.landmarks << Landmark.find_or_create_by(name: params[:landmark][:name])

      #@figure.titles.push((Title.find_or_create_by(id: params[:figure][:title_ids])), (Title.find_or_create_by(name: params[:figure][:title])))
      #@figure.landmarks.push((Landmark.find_or_create_by(id: params[:figure][:landmark_ids])), (Landmark.find_or_create_by(name: params[:figure][:landmark])))
      @figure.save
      redirect to "/figures/#{@figure.id}"
    end
  end
