class DepartmentsController < ApplicationController
  before_action :set_department, only: %i[show edit update destroy]

  # GET /departments
  def index
    authorize Department
    @departments = Department.all
  end

  # GET /departments/:id
  def show
    @feedback = Feedback.new
    authorize @department
  end

  # GET /departments/new
  def new
    @department = Department.new
    authorize @department
  end

  # GET /departments/:id/edit
  def edit
    authorize @department
  end

  # POST /departments
  def create
    @department = Department.new(department_params)
    authorize @department

    if @department.save
      redirect_to @department, notice: "Department was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /departments/:id
  def update
    authorize @department

    if @department.update(department_params)
      redirect_to @department, notice: "Department was successfully updated."
      # equivalente a redirect_to department_path(@department)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /departments/:id
  def destroy
    authorize @department
    @department.destroy
    redirect_to departments_url, notice: "Department was successfully destroyed."
    # departments_path => /departments
    # departments_url => http://localhost:3000/departments
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_department
    @department = Department.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def department_params
    params.require(:department).permit(:name, :description, :cover)
  end
end
