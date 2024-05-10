class AddGuestEmailsToViewingParties < ActiveRecord::Migration[7.1]
  def change
    add_column :viewing_parties, :guest_email, :string
    add_column :viewing_parties, :guest_email2, :string
    add_column :viewing_parties, :guest_email3, :string
  end
end
