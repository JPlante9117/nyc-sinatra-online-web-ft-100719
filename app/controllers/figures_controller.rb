class FiguresController < ApplicationController
  get '/figures' do
    erb :'/figures/index'
  end

  get '/figures/new' do
    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])

    if params[:figure][:title_ids]
      params[:figure][:title_ids].each {|id| @figure.title_ids << id}
    end
    if !params[:title][:name].empty?
      @title = Title.find_or_create_by(name: params[:title][:name])
      @figure.titles << @title
    end
    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each {|id| @figure.landmark_ids << id}
    end
    if !params[:landmark][:name].empty?
      @landmark = Landmark.find_or_create_by(params[:landmark])
      @figure.landmarks << @landmark
    end
    @figure.save

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])

    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
      @figure = Figure.find_by_id(params[:id])
      erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])
    @figure.titles = []
    @figure.landmarks = []
    if params[:figure][:title_ids]
      params[:figure][:title_ids].each {|id| @figure.title_ids << id}
    end
    if !params[:title][:name].empty?
      @title = Title.find_or_create_by(name: params[:title][:name])
      @figure.titles << @title
    end
    if params[:figure][:landmark_ids]
      params[:figure][:landmark_ids].each {|id| @figure.landmark_ids << id}
    end
    if !params[:landmark][:name].empty?
      @landmark = Landmark.find_or_create_by(params[:landmark])
      @figure.landmarks << @landmark
    end
    @figure.save

    redirect "/figures/#{@figure.id}"
  end
end
