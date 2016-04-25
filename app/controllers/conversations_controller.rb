class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /channels
  # GET /channels.json
  def index
    @conversations = current_user.conversations.where(:kind=> 'channel')
  end

  # GET /channels/1
  # GET /channels/1.json
  def show
    @conversations = current_user.conversations.where(:kind=> 'channel')
    @direct_conversations = current_user.conversations.where(:kind=> 'direct')
    @message = Message.new
    if(params[:search_user])
      @emails= process_tags(params[:search_user])
      @emails.each do |email|
        user= User.find_by(:email=>email)
        if user && user != current_user
          @conversation.users << user unless @conversation.users.include?(user)
        end
      end
    end

    if(params[:user])
      emails= process_tags(params[:user])
      emails.each do |email|
        user= User.find_by(:email=>email)
        if user && user != current_user
          conversations = current_user.conversations.includes(:users).where(users: {id: user.id}, kind: 'direct')
          if conversations.any?
            @direct_message= conversations.first
          else
            @direct_message= Conversation.new(:name=> 'direct', :kind=> 'direct')
            @direct_message.save
            @direct_message.users << user
            @direct_message.users << current_user
          end
        end
      end
      if(defined?(@direct_message))
        redirect_to(@direct_message)
      end
    end

  end

  # GET /channels/new
  def new
    @conversation = Conversation.new
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  # POST /channels.json
  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.users << current_user
    @conversation.user = current_user
    respond_to do |format|
      @conversation.kind = 'channel'
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /channels/1
  # PATCH/PUT /channels/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /channels/1
  # DELETE /channels/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit(:name, :kind)
    end
end
