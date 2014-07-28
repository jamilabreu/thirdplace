class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :community_users
  has_many :communities, through: :community_users, source_type: Community

  Community::TYPES.each do |community_type|
    has_many community_type.downcase.pluralize.to_sym, -> { where(type: community_type).order(:name) },
      through: :community_users, source: :community, source_type: Community
  end

  %w( Hometown Location ).each do |community_type|
    define_method "#{community_type.downcase}_ids" do
      self.send(community_type.downcase.pluralize).map(&:city_id)
    end

    define_method "#{community_type.downcase}_ids=" do |ids|
      cities = []
      Array(ids).reject(&:blank?).each do |id|
        city = City.find(id)
        hash = city.attributes.except("id", "type", "created_at", "updated_at").merge("city_id" => city.id)
        place = community_type.constantize.create_with(hash).find_or_create_by(city_id: id)
        cities << place
      end
      update(community_type.downcase.pluralize => cities)
    end
  end

  def communities_shared_with(user)
    communities & user.communities
  end
end
