class LessonsController < ApplicationController
	before_action :set_lesson, only: [:show, :edit, :update, :destroy]
	require 'twilio-ruby'

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

	# def find_tutor
	# 	available_tutors = []
	# 	available_tutors.push(User.where(available: true))
	# 	tutor_pick = available_tutors.sample

	# 	call_number = tutor_pick.phone
	# 	account_sid = 'ACd9b890783cf8f0fa55ee0954796dbb6a'
	# 	auth_token = 'aff84a169feb8699c33d0d21828690ed'
	# 	@client = Twilio::REST::Client.new account_sid, auth_token

	# 	call = @client.account.calls.create (:url => "https://demo.twilio.com/welcome/voice/")
	# 	:to => call_number.to_s,
	# 	:from => "+16173408968"


end