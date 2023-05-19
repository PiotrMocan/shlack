class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :age, :gender

  has_one :account, serializer: AccountSerializer
end
