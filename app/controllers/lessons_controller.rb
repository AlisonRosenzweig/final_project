class LessonsController < ApplicationController
	before_action :set_lesson, only: [:show, :edit, :update, :destroy]

	def show
	end

	def new
		@lesson = Lesson.new
	end

	def create
		@lesson = Lesson.new(lesson_params)

		respond_to do |format|
			if @lesson.save
				format.html { redirect_to @lesson, notice:  'We\'ll have a tutor for you ASAP!'}
				format.json {render :show, status: :ok, locations: @lesson }
			else
				format.html {render :edit }
				format.json { render json: @lesson.errors, status: :unprocessable_entity }
			end
		end
	end

	private

	def set_lesson
		@lesson = Lesson.find(params[:id])
	end

	def lesson_params
		params.require(:lesson).permit(:topic)
end