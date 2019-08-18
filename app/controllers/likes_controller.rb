class LikesController < ApplicationController
  before_action :logged_in_user, only:[:create,:destroy]

  def create
    @answer = Answer.find(params[:answer_id])
    @answer.iine(current_user)
    @answer.reload
    respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
    end
  end

  def destroy
    @answer = Answer.find(params[:answer_id])
    @answer.uniine(current_user)
    @answer.reload
    respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
    end
  end
end