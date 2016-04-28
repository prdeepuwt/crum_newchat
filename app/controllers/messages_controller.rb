class MessagesController < ApplicationController
  before_action :set_message, only: [:update, :destroy]
  before_action :authenticate_user!

  def create
    @message = Message.new
    @message.body = params[:message][:body]
    @message.conversation_id = params[:message][:conversation_id]
    @message.user= current_user
    authorize @message
    respond_to do |format|
      if @message.save
        if params[:message][:attatchments_attributes]
          params[:message][:attatchments_attributes].each do |attatchment|
            Attatchment.create!(file: attatchment[:file], message: @message) unless attatchment[:file].blank?
          end
        end

        format.json {}
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
        format.js {}
      end
    end
  end

  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
      authorize @message
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit!
      #params.require(:message).permit(:body, :conversation_id, attatchments_attributes: [:file])
    end
end
