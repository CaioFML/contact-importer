module API
  module V1
    class ContactsController < ApplicationController
      def index
        @contacts = current_user.contacts

        render json: @contacts
      end
    end
  end
end
