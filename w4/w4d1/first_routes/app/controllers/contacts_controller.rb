class ContactsController < ApplicationController
  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render json: contact.errors.full_messages, status: unprocessable_entity
    end
  end
  
  def destroy
    contact = Contact.find(params[:id])
    contact.destroy!
    render json: contact
  end
  
  # def index # naive implementation
  #   user = User.find(params[:user_id])
  #   contacts = (user.contacts + user.shared_contacts).uniq
  #   render json: contacts
  # end
  
  def index # ActiveRecord/SQL implementation
    user_id = params[:user_id]
    contacts = Contact
      .joins('LEFT OUTER JOIN contact_shares ON contacts.id = contact_shares.contact_id')
      .where(
        'contacts.user_id = :user_id OR contact_shares.user_id = :user_id',
        :user_id => user_id
      )
      .distinct
    render json: contacts
  end
  
  def show
    contact = Contact.find(params[:id])
    render json: contact
  end
  
  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      render json: contact
    else
      render json: contact.errors.full_messages, status: unprocessable_entity
    end
  end
  
  private
  
  def contact_params
    params.require(:contact).permit(:user_id, :name, :email)
  end
end