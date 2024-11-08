class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[show edit update destroy]

  # GET /employees/1
  def show
    @feedback = Feedback.new
  end

  # GET /employees/new
  # GET	/departments/:department_id/employees/new
  def new
    @department = Department.find(params[:department_id])
    @employee = Employee.new
    @departments = Department.all
    @employees = @department.employees
  end

  # GET /employees/1/edit
  def edit
    @department = @employee.department
    @departments = Department.all
    @employees = @department.employees
  end

  # POST /employees
  # POST	/departments/:department_id/employees
  def create
    @department = Department.find(params[:department_id])
    @departments = Department.all
    @employees = @department.employees

    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to @employee.department, notice: "Employee was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /departments/:department_id/employees/:id
  def update
    @department = @employee.department
    @departments = Department.all
    @employees = @department.employees

    @employee.skip_password_validation = true

    if @employee.update(employee_params)
      redirect_to @employee.department, notice: "Employee was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
    redirect_to @employee.department, notice: "Employee was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:name, :nationality, :email, :position, :birth_date,
                                     :department_id, :manager_id, :avatar, :password, :password_confirmation)
  end
end
