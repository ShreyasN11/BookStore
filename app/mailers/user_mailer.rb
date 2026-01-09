class UserMailer < ApplicationMailer
    default from: "notifications@example.com"

    def welcome_email
      @user = params[:user]
      @url  = "http://example.com/login"
      mail(to: @user.email, subject: "Welcome to My Awesome Site")
    end

    def order_receipt(order)
        @order = order
        @user = order.user
    
        pdf = WickedPdf.new.pdf_from_string(
          render_to_string(
            template: 'orders/show',
            layout: 'pdf',   
            formats: [:html],
            locals: { :@order => @order }
          )
        )
    
        attachments["Order_#{@order.id}_Receipt.pdf"] = pdf
    
        mail(to: @user.email, subject: "Your EBookStore Receipt - Order ##{@order.id}")
    end
    
end
