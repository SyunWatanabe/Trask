# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy new]
  before_action :set_search

  def set_search
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @get_answers_ranks = Question.reorder('answers_count desc').order('created_at desc')
    @iine_ranks = Answer.reorder('likes_count desc').order('created_at desc')
    @sub_categories = SubCategory.all
    @questions = Question.all
  end

  def index
    @search = Question.ransack(params[:q])
    @search_questions = @search.result.page(params[:page])
    @sub_categories = SubCategory.all
    @questions = Question.paginate(page: params[:page])
    @get_answers_ranks = Question.reorder('answers_count desc').order('created_at desc')
    @iine_ranks = Answer.reorder('likes_count desc').order('created_at desc')
    @questions = @questions.tagged_with(params[:tag_name].to_s) if params[:tag_name]
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.paginate(page: params[:page], per_page: 5)
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.where(id: params[:id], user_id: current_user.id).first
    if @question.update_attributes(question_params)
      flash[:success] = '質問を変更しました'
      redirect_to @question.user
    else
      render 'edit'
    end
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[:success] = '質問を投稿しました！！'
      redirect_to questions_url
    else
      render :new
    end
  end

  def destroy
    @question = Question.where(id: params[:id], user_id: current_user.id).first
    @question.destroy
    flash[:success] = '質問を削除しました'
    redirect_to questions_url
  end

  def rank
    @get_answers_ranks = Question.reorder('answers_count desc').order('created_at desc').paginate(page: params[:page])
    @iine_ranks = Answer.reorder('likes_count desc').order('created_at desc').paginate(page: params[:page])
    @sub_categories = SubCategory.all
    @questions = Question.all
  end

  def category
    @category = Category.find(params[:id])
    @category_questions = Question.where(category_id: params[:id])
    @sub_categories = SubCategory.all
    @questions = Question.all
  end

  def subcategory
    @sub_category = SubCategory.find(params[:id])
    @sub_category_questions = Question.where(sub_category_id: params[:id])
    @sub_categories = SubCategory.all
    @questions = Question.all
  end

  private

  def question_params
    params.require(:question).permit(:title, :content, :picture, :tag_list, :category_id, :sub_category_id)
  end
end
