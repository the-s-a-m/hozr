# encoding: UTF-8

class FaxesController < AuthorizedController
  belongs_to :case, :optional => true
  has_scope :by_state
  has_scope :per, :default => 50

  def new
    render 'show_modal'
  end

  def create
    resource.sender = current_user.object
    if resource.save
      resource.send_fax

      flash.notice = 'An fax gesendet...'
      render 'show_flash'
    else
      render 'replace_form'
    end
  end
end
