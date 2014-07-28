class CommunityUser < ActiveRecord::Base
  belongs_to :community, polymorphic: true
  belongs_to :user
end
