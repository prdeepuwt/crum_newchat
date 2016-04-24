class BookmarksController < ApplicationController
  before_action :authenticate_user!
  def index
    authorize Bookmark
  end
  def create
    bookmark = Bookmark.where( message_id: params[:bookmark][:message_id], user_id: current_user.id ).first
    
    if bookmark
      bookmark.destroy
    else
      @bookmark = Bookmark.new(bookmark_params)
      @bookmark.user=current_user
      authorize @bookmark 
      respond_to do |format|
        if @bookmark.save
          format.js {}
        else
          format.js {}
        end
      end     
    end

  end


  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:message_id)
    end
end
