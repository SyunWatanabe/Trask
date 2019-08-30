class CommentsController < ApplicationController
  before_action :logged_in_user, only:[:create,:destroy]
  before_action :validate_user, only: :destroy

  def create
    @answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.new(comment_params) 
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました！！"
      redirect_to @comment.answer
    else
      render template: "answers/show"
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_to request.referrer || root_url
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :answer_id, :user_id)
    end

    def validate_user
      @comment = Comment.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end