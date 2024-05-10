class ViewingParty < ApplicationRecord
   has_many :user_parties
   has_many :users, through: :user_parties

   validates :guest_email, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP }
   validates :guest_email2, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP }
   validates :guest_email3, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP }

   def find_host
      users.where("user_parties.host = true").first
   end
end
