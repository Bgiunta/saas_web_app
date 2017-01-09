class ContactsController < ApplicationController
  # GET request to /contact-us
  def new
    @contact = Contact.new
  end
  
  # creates new contact and sends email
  def create
    @contact = Contact.new(contact_params)
    # save to the db
    if @contact.save
      flash[:success] = "Message sent."
      redirect_to new_contact_path
      # store form field parameters to variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # put variables into contact mailer and send email
      ContactMailer.contact_email(name, email, body).deliver
    else
      # handle errors if the save does not go through
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  private
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end