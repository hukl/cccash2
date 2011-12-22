class User < ActiveRecord::Base
  devise :database_authenticatable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :name, :admin, :tainted, :password, :password_confirmation

  # These are workshifts which have been assigned to the user
  # who will most likely be an angel
  has_many  :workshifts

  # These are workshifts which have been cleared by the
  # user (which must be in admin in order to do so)
  has_many  :cleared_workshifts,
            :class_name  => 'Workshift',
            :foreign_key => 'cleared_by_id'

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login
  validates_length_of       :name,     :maximum => 100

  scope :admins,  where( :admin => true )
  scope :angels,  where( :admin => false )
  scope :busy,    joins(:workshifts).where(
    ["workshifts.user_id = users.id AND workshifts.state <> 'cleared'"]
  )

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def angel?
    !admin?
  end

  # FIXME: Legacy method added while changing workshift association to has_many
  # Finds the 'current' workshift of the user, which should be the only one which
  # is not cleared
  def workshift
    workshifts.find :first,
                    :conditions => ["state <> 'cleared'"]
  end

  def destroy
    if 0 < Workshift.find_all_by_user_id(id).count
      errors.add(:workshifts, "Can't delete User with workshift(s)")
      return false
    else
      super
    end
  end

  def active_workshift
    Workshift.find(:first, :conditions => ["state IN (?) AND user_id = ?", ["waiting_for_login", "active", "standby"], id])
  end


  def end_workshift
    if active_workshift && active_workshift.event_possible?(:logout)
      active_workshift.logout!
    end
  end

end
