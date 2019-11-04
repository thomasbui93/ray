class Ray::Exceptions::ApiException < StandardError
  include ActiveModel::Serialization

  attr_reader :status, :code, :message
end