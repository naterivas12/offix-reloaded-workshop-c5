class FeedbacksController < ApplicationController
  before_action :set_feedback, only: %i[show edit update destroy]

  # GET /feedbacks
  def index
    @feedbacks = Feedback.all
  end

  # GET /feedbacks/1
  def show; end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # GET /feedbacks/1/edit
  def edit; end

  # POST /feedbacks
  # POST /departments/:department_id/feedbacks
  # POST /employees/:employee_id/feedbacks
  def create
    @feedback = Feedback.new(feedback_params)
    if params[:department_id]
      @feedbackable = Department.find(params[:department_id])
    elsif params[:employee_id]
      @feedbackable = Employee.find(params[:employee_id])
    end

    @feedback.feedbackable = @feedbackable
    @feedback.employee = current_employee

    if @feedback.save
      redirect_to @feedbackable, notice: "Feedback was successfully created."
    else
      render @feedbackable, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /feedbacks/1
  def update
    if @feedback.update(feedback_params)
      redirect_to @feedback, notice: "Feedback was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /feedbacks/1
  def destroy
    @feedback.destroy
    redirect_to @feedback.feedbackable, notice: "Feedback was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_feedback
    @feedback = Feedback.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def feedback_params
    params.require(:feedback).permit(:content)
  end
end
