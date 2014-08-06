class Lesson < ActiveRecord::Base
	belongs_to :tutor, :class_name => 'User', :foreign_key => 'tutor_id'
	belongs_to :student, :class_name => 'User', :foreign_key => 'student_id'
end
