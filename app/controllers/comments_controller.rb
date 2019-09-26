# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]

  def create
    @answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = 'コメントしました！！'
      redirect_to @comment.answer
    else
      render template: 'answers/show'
    end
  end

  def destroy
    @comment = Comment.where(id: params[:id], user_id: current_user.id).first
    @comment.destroy
    flash[:success] = 'コメントを削除しました'
    redirect_to request.referrer || root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :answer_id, :user_id)
  end
end
