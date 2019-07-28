class QuestionsController < ApplicationController
  before_action :logged_in_user, only:[:create,:destroy,:new]
  before_action :correct_user, only: :destroy
  before_action :set_search
  
  def set_search
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @get_answers_ranks = Question.reorder('answers_count desc').order('created_at desc')
    @iine_ranks = Answer.reorder('likes_count desc').order('created_at desc')
  end

  def index
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @questions = Question.paginate(page: params[:page])
    @get_answers_ranks = Question.reorder('answers_count desc').order('created_at desc')
    @iine_ranks = Answer.reorder('likes_count desc').order('created_at desc')
    if params[:tag_name]
      @questions = @questions.tagged_with("#{params[:tag_name]}")
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.paginate(page: params[:page], :per_page => 5)
  end
  

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      flash[:success] = "質問を変更しました"
      redirect_to @question.user
    else
      render 'edit'
    end
  end

  def create
    @question = current_user.questions.new(question_params)
    if  @question.save
      flash[:success] = "質問を投稿しました！！"
      redirect_to questions_url
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    flash[:success] = "質問を削除しました"
    redirect_to questions_url
  end

  def rank
    @get_answers_ranks = Question.reorder('answers_count desc').order('created_at desc').paginate(page: params[:page])
    @iine_ranks = Answer.reorder('likes_count desc').order('created_at desc').paginate(page: params[:page])
  end

  private
    def question_params
      params.require(:question).permit(:title, :content, :picture, :tag_list)
    end

    def correct_user
      @question = current_user.questions.find_by(id: params[:id])
      redirect_to root_url if @question.nil?
    end
end