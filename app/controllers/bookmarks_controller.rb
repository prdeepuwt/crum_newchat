class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:destroy]

  def create
    bookmark = Bookmark.where( message_id: params[:bookmark][:message_id], user_id: current_user.id ).first
    if bookmark
      bookmark.destroy
    else
      @bookmark = Bookmark.new(bookmark_params)
      @bookmark.user=current_user 
      respond_to do |format|
        if @bookmark.save
          format.js {}
        else
          format.js {}
        end
      end     
    end

  end



  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      @bookmark = Bookmark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:message_id)
    end
end
