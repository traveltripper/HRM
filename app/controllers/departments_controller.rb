class DepartmentsController < ApplicationController
  before_action :authenticate_employee!
  load_and_authorize_resource
  layout 'dashboard'
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Departments", :departments_path

  # GET /departments
  # GET /departments.json
  def index
    @departments = Department.all
  end

  def employees    
    @department = Department.find(params[:id])
    @employees = @department.employees
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    add_breadcrumb "Department"
  end

  # GET /departments/new
  def new
    @department = Department.new
    add_breadcrumb "Add Department"
  end

  # GET /departments/1/edit
  def edit
    add_breadcrumb "Edit Department"
  end
  
  def manager    
    @emp = Employee.where(:manager_id => nil, :department_id=>params[:id]).first
    if @emp.nil?
      render json: {employee_id: '', employee_name: '' }
    else
      render json: {employee_id: @emp.id, employee_name: @emp.fullname }
    end
    
  end
  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to @department, notice: 'Department was successfully created.' }
        format.json { render :show, status: :created, location: @department }
      else
        format.html { render :new }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to @department, notice: 'Department was successfully updated.' }
        format.json { render :show, status: :ok, location: @department }
      else
        format.html { render :edit }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to departments_url, notice: 'Department was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
       params.require(:department).permit(:name)
    end
end
