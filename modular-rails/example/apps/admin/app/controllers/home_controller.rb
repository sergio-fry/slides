module Admin
  class HomeController < ApplicationController
    def index
      render text: :OK
    end
  end
end
