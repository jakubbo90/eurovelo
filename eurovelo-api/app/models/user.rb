class User < ActiveRecord::Base
  attr_accessor :skip_email
  ROLES = %i[super_admin local_admin author]
  include ActiveModel::Dirty
  rolify
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
  include DeviseTokenAuth::Concerns::User
  
  belongs_to :parent, class_name: 'User', optional: true
  has_many :children, class_name: 'User', foreign_key: 'parent_id'
  belongs_to :authorizer, class_name: "User", foreign_key: "authorizer_id", optional: true
  belongs_to :region
  has_many :places, dependent: :destroy
  has_many :trails, dependent: :destroy
  has_many :alerts, dependent: :destroy
  
  after_save :add_roles
  after_create :send_confirmation_email
  before_validation :assign_password_before_create, on: :create
  after_update :send_password_expiry_date, if: :is_password_changed?
  before_destroy :remove_from_parent_id
  
  validate :password_complexity
  validates :first_name, :last_name, :phone, :email, :company, :region_id, presence: {message: "cannot be blank"}
  
  def skip_email
    @skip_email || false
  end
  
  def has_role?
    self.role.present?
  end
  
  def superadmin?
    self.role == "super_admin"
  end
  
  def localadmin?
    self.role == "local_admin"
  end
  
  def author?
    self.role == "author"
  end  
  
  def is_password_changed?
    encrypted_password_before_last_save != "" && self.saved_change_to_encrypted_password? && self.skip_email != true
  end  
  
  def add_roles
    self.add_role "#{self.role}"
  end
  
  def send_confirmation_email
    self.send_confirmation_instructions
  end
  
  def assign_password_before_create
    self.password = Devise.friendly_token(50) + "R$" if self.encrypted_password.blank?
    self.password_created_at = DateTime.now
  end
  
  def change_objects_owner(new_user_id)
    self.trails.update_all(user_id: new_user_id)
    self.alerts.update_all(user_id: new_user_id)
    self.places.update_all(user_id: new_user_id)
  end
  
  def send_password_expiry_date
    UserMailer.send_reset_password_info(self).deliver
  end
  
  def remove_from_parent_id
    User.where(parent_id: self.id).update_all(parent_id: User.find_by(role: "super_admin").id)
  end
  
  private
  def password_complexity
    if password.present? && !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\W)./)
      errors.add :password, "must include at least one lowercase letter, one uppercase letter and one special sign"
    end
  end
end
