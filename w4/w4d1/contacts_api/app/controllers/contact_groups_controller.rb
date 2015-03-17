class ContactGroupsController < ApplicationController
  def create
    c_group = ContactGroup.new(contact_group_params)
    if c_group.save
      render json: c_group
    else
      render json: c_group.errors.full_messages, status: :unprocessable_entity
    end 
  end
  
  def destroy
    c = ContactGroup.find(params[:id])
    c.destroy!
    render json: c
  end
  
  def index
    if params[:user_id]
      user_groups = User.find(params[:user_id]).contact_groups
      render json: user_groups
    elsif params[:contact_id]
      contact_groups = Contact.find(params[:contact_id]).contact_groups
      render json: contact_groups
    end
  end
  
  def show
    c = ContactGroup.find(params[:id])
    render json: c
  end
  
  def update
    c = ContactGroup.find(params[:id])
    if c.update(contact_group_params)
      render json: c
    else
      render json: c.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  private

  def contact_group_params
    params.require(:contact_group).permit(:user_id)
  end
end
