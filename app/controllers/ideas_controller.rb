class IdeasController < ApplicationController
  require 'will_paginate/array'
  before_action :set_idea, only: %i[show edit update destroy ]
  before_action :authenticate_user!
  before_action :check_user, only: %i[show edit update destroy]
  before_action :del_cache, except: [:index, :filtered]
  @id = Idea.all 
  # GET /ideas or /ideas.json
  def index
    
    if session[:dom] 
      domain = session[:dom]
      
      @ideas = Idea.where(domain: '111')
      domain.each do |d|
        @ideas |= Idea.where "domain LIKE ?", "%#{d}%"
      end
      
      if current_user.admin?
        @ideas &= Idea.where "user_id != ?","#{current_user.id}"
      else
        @ideas &= Idea.where(user_id: current_user.id)
      end
    else
      if current_user.admin?
        @ideas =Idea.all
      else
        @ideas = current_user.ideas
      end
    end

    @id = []
  
    current_user.favourites.each do |fav|
      #@ideas.delete(Idea.find(fav.idea_id))
      @id = @id.append(Idea.find(fav.idea_id))
    end
 

    if @ideas !=[]
      @ideas = @ideas.order(updated_at: :desc)
    end
    @ideas.each do |idea|
      if !@id.include?(idea)
        @id.append(idea)     
      end
    end

    # @id.sort_by(&:@id.title)
    # @ideas.sort_by(&:@ideas.title)
    @ideas = @id 

    @ideas = @ideas.paginate(page: params[:page], per_page: 12)
    
  end

  def filtered
    
    if params.has_key?(:dom)
      params[:dom].shift
      domain = params[:dom]
      session[:dom] = domain
      redirect_back fallback_location: ideas_path
    end
  end

  # GET /ideas/1 or /ideas/1.json
  def show
    @favourite_exists = Favourite.where(idea: @idea, user: current_user) ==[] ? false : true
  end

  # GET /ideas/new
  def new
    if current_user.admin?
      redirect_to ideas_path
    end
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas or /ideas.json
  def create
    if current_user.admin?
      redirect_to ideas_path
    end
    #byebug
    params[:idea][:domain].shift
    domain = params[:idea][:domain].join(',')
    @idea = Idea.new({"title"=>params[:idea][:title], "decription"=>params[:idea][:decription], "domain"=>domain, "stake"=>params[:idea][:stake], "thumbnail"=> params[:idea][:thumbnail]})
    @idea.user_id = current_user.id

    respond_to do |format|
      if @idea.save
        format.html { redirect_to @idea, notice: "Idea was successfully created." }
        format.json { render :show, status: :created, location: @idea }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ideas/1 or /ideas/1.json
  def update
    respond_to do |format|
      params[:idea][:domain].shift
      domain = params[:idea][:domain].join(',')
      if @idea.update({"title"=>params[:idea][:title], "decription"=>params[:idea][:decription], "domain"=>domain, "stake"=>params[:idea][:stake], "thumbnail"=> params[:idea][:thumbnail]})
        format.html { redirect_to @idea, notice: "Idea was successfully updated." }
        format.json { render :show, status: :ok, location: @idea }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ideas/1 or /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: "Idea was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def check_user
    if current_user.id != Idea.find(params[:id]).user_id && !current_user.admin?
      render 'home/error'
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

  def del_cache
    
    if session[:dom] 
      session.delete(:dom)
    end 
    
  end
    # Only allow a list of trusted parameters through.
    # def idea_params
    #   
    #   params.require(:idea).permit(:thumbnail, :title, :decription, :domain, :stake, :user)
    # end
end
