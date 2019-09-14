class ApplicationController < ActionController::Base
  before_action :set_user_actions
  before_action :validate_user, only: :destroy

  def validate_user
    @model = controller_name.classify.underscore
    instance_variable_set("@#{@model}", @user_actions.find_by(id: params[:id]))
    redirect_to root_url if instance_variable_get("@#{@model}").nil?
  end

  include SessionsHelper
end
