ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")
class Contribution < ActiveRecord::Base
  belongs_to :user
  belongs_to :typecategory
  belongs_to :areacategory
  has_many :reactions
  has_many :newfavorites
  has_many :favreactions
end

class User < ActiveRecord::Base
  has_many :contributions
  has_many :reactions
  has_secure_password
end

class Reaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :contribution
end

class Newfavorite < ActiveRecord::Base
  belongs_to :contribution
end

class Favreaction < ActiveRecord::Base
  belongs_to :contribution
end

class Areacategory < ActiveRecord::Base
  has_many :contributions
end

class Typecategory < ActiveRecord::Base
  has_many :contributions
end