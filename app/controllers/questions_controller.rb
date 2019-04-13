class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :authorize_user, except: %i[create]

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to user_path(@question.user), notice: 'Question was successfully created.'
    else
      render :edit
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'Question was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /questions/1
  def destroy
    user = @question.user

    @question.destroy
    redirect_to user_path(user), notice: 'Question was successfully deleted.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def question_params
    params.require(:question).permit(:user_id, :text, :answer)
  end

  def authorize_user
    reject_user unless @question.user == current_user
  end
end
