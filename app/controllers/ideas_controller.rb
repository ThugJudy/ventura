class IdeasController < ApplicationController
  before_action :set_idea, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :check_user, only: %i[show edit update destroy]
  
  # GET /ideas or /ideas.json
  def index
    if current_user.ideas.count == 0
      render html: "no ideas"
  else
    if params.has_key?(:dom)
      @ideas = Idea.where(domain: params[:dom])
    else
      @ideas = Idea.all
    end
    if current_user.admin?
      @ideas = @ideas.paginate(page: params[:page], per_page: 12)
    else
      @ideas = @ideas.find_by(user_id: current_user.id).paginate(page: params[:page], per_page: 12)
    end
  end
  end

  def filtered
    byebug
    if params.has_key?(:dom)
      @ideas = Idea.where(domain: params[:dom])
    else
      @ideas = Idea.all
    end
byebug
    if current_user.admin?
      @ideas = @ideas.paginate(page: params[:page], per_page: 12)
    else
      @ideas = @ideas.find_by(user_id: current_user.id).paginate(page: params[:page], per_page: 12)
    end
  end

  # GET /ideas/1 or /ideas/1.json
  def show
    @favourite_exists = Favourite.where(idea: @idea, user: current_user) ==[] ? false : true
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas or /ideas.json
  def create

    domain = params[:idea][:domain].map(&:inspect).join(',')
    domain = domain.remove("\\","\"")
    @idea = Idea.new({"title"=>params[:idea][:title], "decription"=>params[:idea][:decription], "domain"=>domain, "stake"=>params[:idea][:stake]})
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
      domain = params[:idea][:domain].map(&:inspect).join(',')
      domain = domain.remove("\\","\"")
      if @idea.update({"title"=>params[:idea][:title], "decription"=>params[:idea][:decription], "domain"=>domain, "stake"=>params[:idea][:stake]})
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

    # Only allow a list of trusted parameters through.
    # def idea_params
    #   byebug
    #   params.require(:idea).permit(:thumbnail, :title, :decription, :domain, :stake, :user)
    # end
end
