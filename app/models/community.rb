class Community < ActiveRecord::Base
	TYPES = %w( Employer Gender Hometown Location Orientation Religion School )

	has_many :community_users
	has_many :users, through: :community_users
end
