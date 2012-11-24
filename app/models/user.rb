class User < ActiveRecord::Base

  has_attached_file :face,
    :default_style => :s80,
    :styles => {
    :default => "80x80#",
    :s140 => "140x160#",
    :s128 => "128x128#",
    :s80 => "80x80#",
    :s64 => "64x64#",
    :s48 => "48x48#",
    :s32 => "32x32#",
    :s16 => "16x16#",
  },
    :default_url => "default_faces/:style.jpg"
  attr_accessor :password
  before_save :encrypt_password, :default_money
  has_many :user_categories
  has_many :storages
  has_many :rules
  has_many :records
  has_many :friends
  has_many :msgs


  validates_confirmation_of :password
  validates :password, :on => :create, :presence => true
  validates :email,  :presence => true #,:message => "邮箱地址不能为空"
  validates :name, :presence => true #, :message => "名字不能为空"
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  validates_attachment_content_type :face, :content_type => 'image/jpeg'
  def self.authenticate(email,password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
    end
  end
  def default_money
    self.money = 0.00 unless self.money
  end

  def public_category_a

  end

  def public_category_a=(value)

  end

  def public_category_b

  end

  def public_category_b=(value)
    self.category_id = value
  end
end
