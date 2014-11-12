class User
  include Mongoid::Document

  field :email, type: String

  authenticates_with_sorcery!
end
