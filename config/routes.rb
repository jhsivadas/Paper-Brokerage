Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root "login#index"
  # Routes for the Holding resource:

  # CREATE
  post("/insert_holding", { :controller => "holdings", :action => "create" })
          
  # READ
  get("/holdings", { :controller => "holdings", :action => "index" })
  
  get("/holdings/:path_id", { :controller => "holdings", :action => "show" })
  
  # UPDATE
  
  post("/modify_holding/:path_id", { :controller => "holdings", :action => "update" })
  
  # DELETE
  get("/delete_holding/:path_id", { :controller => "holdings", :action => "destroy" })

  #------------------------------

  # Routes for the Order resource:

  # CREATE
  post("/insert_order/:type", { :controller => "orders", :action => "create" })
          
  # READ
  # get("/orders", { :controller => "orders", :action => "index" })
  
  get("/orders/:path_id/:stock/:type", { :controller => "orders", :action => "index" })

  post("/placeholder/:path_id", { :controller => "orders", :action => "find_order" })

  get("/route_to_order/:path_id", {:controller => "orders", :action=>"route"})
  # post("/route_to_order/:path_id/:stock", {:controller => "orders", :action=>"find_order"})

  
  # UPDATE
  
  post("/modify_order/:path_id", { :controller => "orders", :action => "update" })
  
  # DELETE
  get("/delete_order/:path_id", { :controller => "orders", :action => "destroy" })

  #------------------------------

  # Routes for the Account resource:

  # CREATE
  post("/insert_account", { :controller => "accounts", :action => "create" })
          
  # READ
  get("/accounts", { :controller => "accounts", :action => "index" })
  
  get("/accounts/:path_id", { :controller => "accounts", :action => "show" })
  
  # UPDATE
  
  post("/modify_account/:path_id", { :controller => "accounts", :action => "update" })
  
  # DELETE
  get("/delete_account/:path_id", { :controller => "accounts", :action => "destroy" })

  #------------------------------

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
