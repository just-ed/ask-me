class UsersController < ApplicationController
  before_action :load_user, except: %i[index new create]
  before_action :authorize_user, except: %i[index new create show]

  def index
    @users = User.all
    @hashtags = Hashtag.order(name: :asc)
  end

  def new
    redirect_to root_url, alert: 'You are already signed in' if current_user.present?

    @user = User.new
  end

  def create
    redirect_to root_url, alert: 'You are already signed in' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Welcome! :)'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile successfully updated :)'
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def destroy
    @user.destroy
    redirect_to root_url, notice: 'Goodbye :('
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :bg_color)
  end

  def load_user
    @user ||= User.friendly.find(params[:id])
  end

  def authorize_user
    reject_user unless @user == current_user
  end
end
