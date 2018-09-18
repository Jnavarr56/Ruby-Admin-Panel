class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    #ALL COURSES
    @courses = Course.all

    #NUMBER OF SECTIONS FOR EACH COURSE:
    @courses_num_sections = {} #<----- KEY = COURSE PRIMARY KEY, VALUE = NUMBER OF COURSE SECTIONS
    @courses.each do |course_to_check_sections_num|
      @courses_num_sections[course_to_check_sections_num[:id]] = Section.where('course_id = ?', course_to_check_sections_num[:id]).length
    end

    #NUMBER OF STUDENTS FOR EACH COURSE:
    @courses_num_students = {} #<----- KEY = COURSE PRIMARY KEY, VALUE = NUMBER OF COURSE STUDENTS
    @courses.each do |course_to_get_sections|
      num_of_students = 0
      Section.where('course_id = ?', course_to_get_sections[:id]).each do |sections_to_check_enrollment_num|
        num_of_students =  num_of_students + Enrollment.where('section_id =?', sections_to_check_enrollment_num[:id]).length
      end
      @courses_num_students[course_to_get_sections[:id]] = num_of_students
    end

    #INSTRUCTOR FOR EACH COURSE:
    @course_instructor = {} #<----- KEY = COURSE PRIMARY KEY, VALUE = {first_name: COURSE INSTRUCTOR FIRST NAME, last_name: COURSE INSTRUCTOR LAST NAME}
    @courses.each do |course_to_get_instructor|

      
      if Section.find_by(course_id: course_to_get_instructor[:id]) != nil
        Enrollment.where('section_id = ?', Section.find_by(course_id: course_to_get_instructor[:id])[:id]).each do |enrollment_to_get_instructor|
          if User.find_by(id: enrollment_to_get_instructor[:user_id], access: 'instructor') != nil
            @course_instructor[course_to_get_instructor[:id]] = {first_name: User.find_by(id: enrollment_to_get_instructor[:user_id], access: 'instructor')[:first_name], last_name: User.find_by(id: enrollment_to_get_instructor[:user_id], access: 'instructor')[:last_name], self_link: User.find_by(id: enrollment_to_get_instructor[:user_id], access: 'instructor')}
          end    
        end
      end

      

    end


  end
  


  # GET /courses/1
  # GET /courses/1.json
  def show
    @course_sections = Section.where('course_id = ?', @course[:id])
    #INSTRUCTOR FOR CURRENT COURSE BEING VIEWED:
    @course_instructor = {} #<-----THIS STRUCTURE: {first_name: COURSE INSTRUCTOR FIRST NAME, last_name: COURSE INSTRUCTOR LAST NAME}
    if @course_sections.length != 0
      Enrollment.where('section_id = ?', @course_sections[0][:id]).each do |enrollment_to_get_instructor|
        if User.find_by(id: enrollment_to_get_instructor[:user_id], access: 'instructor') != nil
        @course_instructor = {first_name: User.find_by(id: enrollment_to_get_instructor[:user_id], access: 'instructor')[:first_name], last_name: User.find_by(id: enrollment_to_get_instructor[:user_id], access: 'instructor')[:last_name]}
        end
      end
    else
      @course_instructor = {first_name: "N/A", last_name: "N/A"}
    end
    

    #STUDENTS IN EACH CURRENT COURSE BEING VIEWED:
    @section_roster = {morning: [], evening: []} #<-----THIS STRUCTURE: {morning: ['last name, first name'...], evening: ['last name, first name'...],}
    @course_sections.each do |section_to_get_roster|
      if section_to_get_roster[:meeting_scheme] === "MWF"
        Enrollment.where('section_id = ?', section_to_get_roster[:id]).each do |enrollment_to_get_roster|
          if User.find_by(id: enrollment_to_get_roster[:user_id])[:access] === 'instructor'
            next
          else
          @section_roster[:morning].push(User.find_by(id: enrollment_to_get_roster[:user_id])[:last_name] + ", " + User.find_by(id: enrollment_to_get_roster[:user_id])[:first_name])
          end
        end
        #puts @section_roster[:morning].push(section)
      else
        Enrollment.where('section_id = ?', section_to_get_roster[:id]).each do |enrollment_to_get_roster|
          if User.find_by(id: enrollment_to_get_roster[:user_id])[:access] === 'instructor'
            next
          else
          @section_roster[:evening].push(User.find_by(id: enrollment_to_get_roster[:user_id])[:last_name] + ", " + User.find_by(id: enrollment_to_get_roster[:user_id])[:first_name])
          end
        end
      end
    end

    
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:course_title, :course_description)
    end
end
