class ConversationsController < ApplicationController
  def index
    @convo = Conversation.all
  end

  def new
    @conversation = Conversation.new
  end
  def show
    @room_message = RoomMessage.new room: @room
    @room_messages = @room.room_messages.includes(:user)
  end
  def create
    @conversation = Conversation.new 

    if @conversation.save
      flash[:success] = "Room was created successfully"
      redirect_to conversations_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update_attributes(permitted_parameters)
      flash[:success] = "Room #{@conversation.name} was updated successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  protected


end
