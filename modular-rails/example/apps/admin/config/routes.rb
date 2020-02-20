Rails.application.routes.draw do
  namespace "admin" do
    get "/", to: "welcome#index"
  end
end
