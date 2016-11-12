class User < ApplicationRecord
  rolify :role_cname => 'Worker'
  rolify :role_cname => 'Creator'
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    has_many :relationships
end
