class Response < ActiveRecord::Base
	belongs_to :thread_tables
	belongs_to :users
end
