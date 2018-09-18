class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]

  # GET /enrollments
  # GET /enrollments.json
  def index
    @enrollments = Enrollment.all
    users = User.all
    @users_by_enrollment = {}
    users.each do |user|
      @users_by_enrollment[user.id] = user
    end
    @sections_by_enrollment = {}
    sections = Section.all
    sections.each do |section|
      @sections_by_enrollment[section.id] = section
    end
    courses = Course.all
    @courses_by_enrollment = {}
    courses.each do |course|
      @courses_by_enrollment[course.id] = {course_obj: course, course_short_name: ""}
      course_title_raw = course.course_title.split(" ")
      course_title_fixed = ""
      course_title_raw.each do |word|
        if word != "of" && word != "the"
          course_title_fixed = course_title_fixed + word[0] 
        end
      end
      @courses_by_enrollment[course.id][:course_short_name] = course_title_fixed + " " + @courses_by_enrollment[course.id][:course_obj][:course_description]
    end
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments
  # POST /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to @enrollment, notice: 'Enrollment was successfully created.' }
        format.json { render :show, status: :created, location: @enrollment }
      else
        format.html { render :new }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to @enrollment, notice: 'Enrollment was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to enrollments_url, notice: 'Enrollment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:section_id, :user_id)
    end
end
