class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token, :reset_token
	before_create :create_activation_digest
	before_save :downcase_email
	has_many :members
	has_many :pics
	has_many :tasks, through: :pics
	has_many :projects, through: :members
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, presence: true, length: { maximum: 255 },
						format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
	has_secure_password					
	validates :password, presence: true, length: {minimum: 6}, allow_nil: true		
	
	def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated?(attribute,token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	# Activate user account
	def activate
		update_columns(activated: true, activated_at: Time.zone.now)
	end	

	# Send activattion email toward user
	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end	

	# Delete the cookies about user
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Set attributes for reconfiguring user password
	def create_reset_digest
		self.reset_token = User.new_token
		update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
	end	

	# Send the email of configuring user password to user
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end	

	# Check Whether the time of requesting is expired or not
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	# Users create a new project by themselves
	def be_owner(project)
		self.members.create(user_id: id, project_id: project.id, owner: true)
	end

	# User is added to new project member
	def be_added_to(project)
		Member.create(user_id: id, project_id: project.id)
	end

	# Check whether user is a member of the project or not
	def member?(project_id)
		self.members.find_by(project_id: project_id)
	end

	# Show all of open projects user have joined or created
	# I want to know how to create the same method 
	# def open_projects
	# 	# Member.where("user_id = ?", id).includes(:project).select { |member| member.project.status == true }
	# end

	private
		# Downcase user email 
		def downcase_email
			self.email.downcase!
		end	

		# Create activation token and digest
		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(activation_token)
		end
end
