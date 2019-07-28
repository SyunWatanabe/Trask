class LikesController < ApplicationController
  before_action :logged_in_user, only:[:create,:destroy]

  def create
    @answer = Answer.find(params[:answer_id])
    unless @answer.iine?(current_user)
      @answer.iine(current_user)
      @answer.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @answer = Like.find(params[:id]).answer
    if @answer.iine?(current_user)
      @answer.reload
      @answer.uniine(current_user)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end