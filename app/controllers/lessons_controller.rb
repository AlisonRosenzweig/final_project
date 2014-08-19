class LessonsController < ApplicationController
	before_action :set_lesson, only: [:show, :edit, :update, :destroy, :tutor_request]
	require 'twilio-ruby'

	skip_before_action :verify_authenticity_token

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


	def find_tutor
		available_tutors = []
		available_tutors.push(User.where(available: true).all)
		@potential_tutor = available_tutors.sample
			
	end


	def tutor_request
		account_sid = 'ACd9b890783cf8f0fa55ee0954796dbb6a'
		auth_token = 'aff84a169feb8699c33d0d21828690ed'
		@client = Twilio::REST::Client.new account_sid, auth_token

		@client.account.messages.create({
			:from => '+16173408968',
			:to => '#{@potential_tutor.phone}',
			:body => 'Hey #{@potential_tutor.first_name}, you\'ve got a lesson request!  Can you help with #{@lesson.topic}'
			})
	end

	private

	def set_lesson
		@lesson = Lesson.find(params[:id])
	end

	def lesson_params
		params.require(:lesson).permit(:topic)
	end

end